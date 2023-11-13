class TouristSite
  attr_reader :name, :address, :place_id

  def initialize(name, address, place_id)
    @name = name
    @address = address
    @place_id = place_id
  end

  def serialized
    {
      id: nil,
      type: "tourist_site",
      attributes: {
        name: name,
        address: address,
        place_id: place_id
      }
    }
  end
end