require_relative 'tour'
require_relative 'tourist'
require_relative 'tour_data_base'
require_relative 'tourist_data_base'
require_relative 'input'

class Core
  include Input

  def initialize
    @tour_db = TourDB.new
    @toursit_db = ToursitDB.new
  end

  def run
    @tour_db = Input.read_filetours
    @toursit_db = Input.read_filetourists
    puts @tour_db
    puts @toursit_db
  end
end
