require 'csv'
require_relative 'movie'
class MovieList 
    def initialize(a)
        @movies = []
    end

    def read_data
        puts @table.class
        puts @table.size
    end

    def to_s
        @movies.each{|mov| puts mov}
    end
end


a=MovieList.new(ARGV)
a.read_data
a.close