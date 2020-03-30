#!/usr/bin/env ruby
require 'tmpdir'
require 'erb'
REQUIRED_RUBY_VERSION='2.6.5'
APP_DIR = File.expand_path('~/auto-deploy/WebProject')
SERVICE_NAME = 'application.service'
  def main  
   #install_ruby
    patch_path
    #install_required_gems(APP_DIR)
    setup_systemd_service(APP_DIR)
    enable_systemd_service
  end

  def install_ruby
    current_dir = Dir.pwd
    Dir.mktmpdir do |directory|
      puts directory
      checkd_run('wget','-O', 'ruby-install-0.7.0.tar.gz', 'https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz')
      checkd_run('tar','-xzvf','ruby-install-0.7.0.tar.gz')
      Dir.chdir('ruby-install-0.7.0')
      checkd_run('sudo','make','install')
    end
    Dir.chdir(current_dir)
    checkd_run('ruby-install','-L')
    checkd_run('ruby-install','--jobs=4','ruby',REQUIRED_RUBY_VERSION)
  end

  def checkd_run(*args)
    command = args.join(' ')
    puts "Running #{command}"
    result = system(*args)
    unless result
      puts "Command #{command} finished error"
      exit(1)
    end
  end

  def install_required_gems(app_dir)
    Dir.chdir(app_dir)
    bundle_path = File.expand_path("~/.rubies/ruby-#{REQUIRED_RUBY_VERSION}/bin/bundler")
    checkd_run('bundle','install')
  end

  def patch_path
    ENV['PATH'] =  ruby_install_path + ':' + ENV['PATH']
  end

  def ruby_install_path
    File.expand_path("~/.rubies/ruby-#{REQUIRED_RUBY_VERSION}/bin") 
  end

  def setup_systemd_service(app_dir)
    template = File.read(File.expand_path('application.service.erb',__dir__))
    path = ENV['PATH']
    bundle_path = File.join(ruby_install_path, 'bundle')
    clojure = binding
    baked_template = ERB.new(template).result(clojure)
    puts baked_template
    file_path = File.join(__dir__, SERVICE_NAME)
    File.write(file_path, baked_template)
    checkd_run('sudo','mv',file_path, '/etc/systemd/system')
    checkd_run('sudo','systemctl','daemon-reload')
  end

  def enable_systemd_service
    checkd_run('sudo','systemctl','enable', SERVICE_NAME) 
  end


  if __FILE__ == $0
    main
  end

