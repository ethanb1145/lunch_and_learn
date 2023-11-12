class Api::V1::FavoritesController < ApplicationController

  def index
    user = User.find_by(api_key: params[:api_key])

    if user
      favorites = user.favorites
      render json: { data: favorites_response(favorites) }
    else
      render json: { error: ["Invalid Api-Key."] }, status: 400
    end
  end

  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      favorite = user.favorites.new(favorite_params)

      if favorite.save
        render json: { success: ["Favorite added successfully."] }, status: :created
      else
        render json: { error: ["Favorite not added. Fill in all fields."] }, status: :unprocessable_entity
      end
    else
      render json: { error: ["Invalid Api-Key."] }, status: 400
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end

  def favorites_response(favorites)
    favorites.map do |favorite|
      {
        id: favorite.id.to_s,
        type: "favorite",
        attributes: {
          recipe_title: favorite.recipe_title,
          recipe_link: favorite.recipe_link,
          country: favorite.country,
          created_at: favorite.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
        }
      }
    end
  end
end