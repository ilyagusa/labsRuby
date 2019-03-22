# 1
class Info
  attr_accessor :type_transport, :country
  def initialize(country, type_transport)
    @country = country
    @type_transport = type_transport
  end

  def to_s
    "Country:#{@country}\nTransport:#{@type_transport}\n"
  end
end
