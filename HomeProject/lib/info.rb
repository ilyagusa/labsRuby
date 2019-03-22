# 1
class Info
  attr_accessor :type_t, :country
  def initialize(country, type_t)
    @country = country
    @type_t = type_t
  end

  def general
    str=country+type_t
  end

  def to_s
    "Country:#{@country}\nTransport:#{@type_t}\n"
  end
end
