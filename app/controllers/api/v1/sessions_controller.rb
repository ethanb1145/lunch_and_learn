class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        "data": {
          "type": "user",
          "id": user.id.to_s,
          "attributes": {
            "name": user.name,
            "email": user.email,
            "api_key": user.api_key
          }
        }
      }, status: :created
    else
      render json: { error: ["Credentials are bad."] }, status: 400
    end
  end
end