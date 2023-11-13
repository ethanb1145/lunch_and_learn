class TouristSitesFacade
  def initialize(country)
    @country = country
  end

  def tourist_sites
    capital_coordinates = CountryService.new.capital_coordinates(@country)

    tourist_sites = PlaceService.new.get_tourist_sites(capital_coordinates[0], capital_coordinates[1])
    serialize_tourist_sites(tourist_sites)
  end

  private

  def serialize_tourist_sites(tourist_sites)
    sites = tourist_sites[:features]&.map do |site|
      TouristSite.new(
        site[:properties][:name],
        site[:properties][:formatted],
        site[:properties][:place_id]
      ).serialized
    end

    { data: sites || [] }
  end
end