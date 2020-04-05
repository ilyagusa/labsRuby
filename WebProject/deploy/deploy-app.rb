#!/usr/bin/env ruby
require 'net/ssh'
require 'net/scp'
require 'tmpdir'
require 'erb'
require 'optparse'
REQUIRED_RUBY_VERSION='2.6.5'
APP_DIR = '/srv/ruby-app'
SERVICE_NAME = 'application'
APP_USER = 'ruby-app'

class Deploy

  def deploy(host,user,password)
    Net::SSH.start(host, user, password: password) do |connection|
      @connection = connection
      @scp = connection.scp
      install_ruby
      copy_application_files
      install_required_gems(APP_DIR)
      create_app_user(APP_USER,APP_DIR)
      setup_systemd_service(APP_DIR)
      enable_systemd_service
      restart_systemd_service
      install_nginx
      create_reverse_proxy
    end
  end

  def install_ruby
    checkd_run('sudo','apt-get','update')
    checkd_run('sudo','apt-get','install','-y','build-essential')
    unless valid_command?('which' , 'ruby-install')
      archive_path = '/tmp/ruby-install-0.7.0.tar.gz'
      checkd_run('wget','-O', archive_path, 'https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz')
      checkd_run('tar','-C', '/tmp','-xzvf', archive_path)
      ruby_install_dir = '/tmp/ruby-install-0.7.0'
      checkd_run('sudo','make','install', dir: ruby_install_dir)
    end
    checkd_run('sudo','ruby-install','-L')
    checkd_run('sudo','ruby-install','--no-reinstall', '--jobs=4', 'ruby',REQUIRED_RUBY_VERSION)
  end

  def checkd_run(*args,dir: nil)
    command = args.join(' ')
    puts "Running #{command}"
    if !dir.nil?
      command = "cd #{dir} && #{command}"
    end
    @connection.exec!(command) do |ch,channel,data|
    print data
    end
  end

  def install_required_gems(app_dir)
    checkd_run('sudo', File.join(ruby_install_path, 'bundle'), 'install',
    '--gemfile', File.join(app_dir,'Gemfile'),'--jobs=4', '--retry=3',
    '--without=deployment'
    )
  end

  def ruby_install_path
    "/opt/rubies/ruby-#{REQUIRED_RUBY_VERSION}/bin"
  end

  def setup_systemd_service(app_dir)
    template = File.read(File.expand_path('application.service.erb',__dir__))
    path = [
      ruby_install_path,
      '/usr/local/bin',
      '/use/bin',
      '/bin',
    ].join(':')

    bundle_path = File.join(ruby_install_path, 'bundle')
    clojure = binding
    baked_template = ERB.new(template).result(clojure)
    

    service_file_name = "#{SERVICE_NAME}.service"
    file_path = File.join(__dir__, service_file_name)
    File.write(file_path, baked_template)
    
    remote_service_path = '/tmp/systemd.service'
    @scp.upload!(file_path,remote_service_path)

    checkd_run('sudo','mv', remote_service_path, File.join('/etc/systemd/system', service_file_name))
    checkd_run('sudo','systemctl','daemon-reload')
  end

  def enable_systemd_service
    checkd_run('sudo','systemctl','enable', SERVICE_NAME) 
  end

  def restart_systemd_service
    checkd_run('sudo','systemctl','restart', SERVICE_NAME) 
  end


  def copy_application_files
    temp_dir = '/tmp/temp-app-dir'
    checkd_run('sudo','rm','-rf', temp_dir)
    @scp.upload!(File.expand_path('..',__dir__), temp_dir, recursive: true)
    checkd_run('sudo','mkdir','-p', APP_DIR)
    checkd_run('sudo', 'cp', '-R', File.join(temp_dir,'*'), APP_DIR)
    checkd_run('sudo','rm','-rf', temp_dir)
  end
  
  def valid_command?(*args)
    command = args.join(' ')
    puts "Checking #{command}"
    result = @connection.exec!(command)
    result.exitstatus == 0
  end
  
  def create_app_user(user_name,app_dir)
    unless valid_command?('id', user_name)
      checkd_run('sudo', 'useradd', user_name,'--home-dir', app_dir, '-M', '-s', '/bin/bash')
    end
    checkd_run('sudo','chown',"#{user_name}:","-R", app_dir)
  end

  def install_nginx
    checkd_run('sudo','apt-get','install','-y','nginx')
  end

  def create_reverse_proxy
    configure_file_name = 'config-my-app'
    conf_file_path = File.join(__dir__, configure_file_name)
    info = "server {
      listen 80 default_server;
      listen [::]:80 default_server;
      root #{APP_DIR}/public;

      index index.html index.htm index.nginx-debian.html;

      server_name _;

      location @app {
              proxy_pass http://127.0.0.1:9292;
              include proxy_params;
      }

      location / {
              try_files $uri $uri.html @app;
      }
    }"
    File.write(conf_file_path, info)
    nginx_configure_path = '/tmp/nginx_configure'
    @scp.upload!(conf_file_path,nginx_configure_path)
    checkd_run('sudo','systemctl','start', 'nginx')
    checkd_run('sudo','rm', '/etc/nginx/sites-available/*')
    checkd_run('sudo','rm','/etc/nginx/sites-enabled/*')
    checkd_run('sudo','mv', nginx_configure_path, File.join('/etc/nginx/sites-available', configure_file_name))
    checkd_run('sudo', 'ln', '-s', "/etc/nginx/sites-available/#{configure_file_name}", "/etc/nginx/sites-enabled/#{configure_file_name}")
    checkd_run('sudo','systemctl','restart', 'nginx')
  end

end


if __FILE__ == $0
  deployer = Deploy.new
  options = {}
  OptionParser.new do |opt|
    opt.on('--user USER') { |o| options[:user] = o }
    opt.on('--password PASSWORD') { |o| options[:password] = o }
    opt.on('--host HOST') { |o| options[:host] = o }
  end.parse!
  if options.size != 3
    puts "Need 3 parameters (--user=user,--password=password,--host=host)"
    exit(1)
  end
  puts options
  deployer.deploy(options[:host],options[:user],options[:password])
  #deployer.deploy('192.168.1.49','user','user')
end

