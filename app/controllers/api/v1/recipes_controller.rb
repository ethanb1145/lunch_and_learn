class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country].presence || random_country
    recipes = RecipeService.new.recipe_search(country)

    if recipes.present? && recipes[:hits].present?
      render json: { data: serialize_recipes(recipes, country) }
    else
      render json: { data: [] }
    end
  end

  private

  def random_country
    country_service = CountryService.new
    countries = country_service.countries

    country_names = countries.map { |country| country[:name][:common] }
    country_names.sample || "Thailand"
  end

  def serialize_recipes(recipes, country)
    recipes[:hits].map do |recipe|
      {
        id: nil,
        type: "recipe",
        attributes: {
          title: recipe[:recipe][:label],
          url: recipe[:recipe][:url],
          country: country,
          image: recipe[:recipe][:image]
        }
      }
    end
  end
end
