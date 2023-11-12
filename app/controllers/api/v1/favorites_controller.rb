class Api::V1::FavoritesController < ApplicationController
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
end