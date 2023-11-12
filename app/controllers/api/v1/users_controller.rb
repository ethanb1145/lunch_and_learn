class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      user.update(api_key: generate_api_key)
      render json: { data: user_response(user) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def user_response(user)
    {
      type: 'user',
      id: user.id.to_s,
      attributes: {
        name: user.name,
        email: user.email,
        api_key: user.api_key
      }
    }
  end

  def generate_api_key
    SecureRandom.hex(16)
  end
end
