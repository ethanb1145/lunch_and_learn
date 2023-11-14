class Api::V1::RecipesController < ApplicationController
  def index
    facade = RecipesFacade.new(params)
    response_data = facade.recipes

    render json: { data: response_data }
  end
end