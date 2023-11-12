require "rails_helper"

RSpec.describe "User Registration API", type: :request do
  describe "POST /api/v1/users" do
    it "creates a new user" do
      post "/api/v1/users", params: { name: "Odell", email: Time.now.to_i.to_s, password: "treats4lyf", password_confirmation: "treats4lyf" } 

      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)

      expect(data).to have_key("data")
      user_data = data["data"]

      expect(user_data).to have_key("type")
      expect(user_data["type"]).to eq("user")
      expect(user_data).to have_key("id")
      expect(user_data).to have_key("attributes")

      attributes = user_data["attributes"]

      expect(attributes).to have_key("name")
      expect(attributes["name"]).to eq("Odell")
      expect(attributes).to have_key("email")
    end

    it "returns errors if registration fails" do
      # Test the case where registration fails (e.g., duplicate email)
    end
  end
end
