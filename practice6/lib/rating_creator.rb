class RatingCreator
  def create(args)
    error('Not enough parameters') if args.size < 1
    error('Input file doesn\'t exist') unless File.exist?(args[0])
  end

  def error(str)
    puts str
    exit
  end

end