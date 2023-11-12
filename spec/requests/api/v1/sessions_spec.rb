require "rails_helper"

RSpec.describe "User Sessions API", type: :request do
  describe "POST /api/v1/sessions" do
    it "creates a new session and returns user data" do
      user = User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf")

      post "/api/v1/sessions", params: { email: "goodboy@ruffruff.com", password: "treats4lyf" }

      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)

      expect(data).to have_key("data")
      user_data = data["data"]

      expect(user_data).to have_key("type")
      expect(user_data["type"]).to eq("user")
      expect(user_data).to have_key("id")
      expect(user_data).to have_key("attributes")
      expect(user_data["attributes"]).to have_key("name")
      expect(user_data["attributes"]).to have_key("email")
      expect(user_data["attributes"]).to have_key("api_key")

      attributes = user_data["attributes"]

      expect(attributes).to have_key("name")
      expect(attributes["name"]).to eq(user.name)
      expect(attributes).to have_key("email")
    end

    it "returns an error if credentials are invalid" do
      post "/api/v1/sessions", params: { email: "error.com", password: "no" }

      expect(response).to have_http_status(400)
      data = JSON.parse(response.body)

      expect(data).to have_key("error")
      expect(data["error"]).to eq(["Credentials are bad."])
    end
  end
end
