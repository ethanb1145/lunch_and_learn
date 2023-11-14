class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country]
    facade = ResourcesFacade.new(country)
    response_data = facade.learning_resources

    render json: { data: response_data }
  end
end