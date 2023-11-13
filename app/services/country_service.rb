class CountryService
  def conn
    Faraday.new(url: "https://restcountries.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def countries
    get_url("/v3.1/all")
  end

  def capital_coordinates(country_name)
    country_data = country_by_name(country_name)
    country_data[:latlng] if country_data
  end

  def country_by_name(country_name)
    countries.find { |country| country[:name][:common] == country_name }
  end
end