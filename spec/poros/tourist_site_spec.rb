require "rails_helper"

RSpec.describe TouristSite do
  it "exists" do
    name = "Tour de l'horloge"
    address = "Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France"
    place_id = "51d28..."

    tourist_site = TouristSite.new(name, address, place_id)

    expect(tourist_site.name).to eq(name)
    expect(tourist_site.address).to eq(address)
    expect(tourist_site.place_id).to eq(place_id)
  end

  it "can be serialized" do 
    name = "Tour de l'horloge"
    address = "Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France"
    place_id = "51d28..."

    tourist_site = TouristSite.new(name, address, place_id)

    serialized = {
      id: nil,
      type: "tourist_site",
      attributes: {
        name: name,
        address: address,
        place_id: place_id
      }
    }

    expect(tourist_site.serialized).to eq(serialized)
  end
end