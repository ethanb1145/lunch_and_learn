require "rails_helper"

RSpec.describe TouristSitesFacade do
  it "returns serialized tourist sites for a specific country" do
    WebMock.allow_net_connect!
    country = "France"

    tourist_sites_data = {
      features: [
        {
          properties: {
            name: "Ruines du château",
            formatted: "Ruines du château, D 37, 23460 Le Monteil-au-Vicomte, France",
            place_id: "514f4e194fdd03ff3f599c1feab7f0f64640f00102f9016e1b800a000000009203125275696e6573206475206368c3a274656175"
          }
        }
      ]
    }

    facade = TouristSitesFacade.new(country)
    result = facade.tourist_sites

    expected_result = {
      data: [
        {
          id: nil,
          type: "tourist_site",
          attributes: {
            name: "Ruines du château",
            address: "Ruines du château, D 37, 23460 Le Monteil-au-Vicomte, France",
            place_id: "514f4e194fdd03ff3f599c1feab7f0f64640f00102f9016e1b800a000000009203125275696e6573206475206368c3a274656175"
          }
        }
      ]
    }

    expect(result.keys).to eq(expected_result.keys)
    expect(result[:data].first[:attributes].keys).to eq(expected_result[:data].first[:attributes].keys)
  end
end