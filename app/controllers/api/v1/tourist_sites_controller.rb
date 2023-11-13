class Api::V1::TouristSitesController < ApplicationController
  def index
    country = params[:country]
    facade = TouristSitesFacade.new(country)
    render json: facade.tourist_sites
  end
end