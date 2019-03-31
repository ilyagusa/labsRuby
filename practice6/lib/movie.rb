class Movie
    attr_reader :title, :imdb, :kinopoisk, :metacritic, :rotten_tomatoes
  def initialize(title, imdb, kinopoisk, metacritic, rotten_tomatoes)
    @title=title
    @imdb=imdb
    @kinopoisk=kinopoisk
    @metacritic=metacritic
    @rotten_tomatoes=rotten_tomatoes
  end

  def ogon_rating
    @ogon_rating=(@imdb + @kinopoisk + (@metacritic + @rotten_tomatoes)/2)/3
  end


end