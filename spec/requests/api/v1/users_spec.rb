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
      expect(user_data["attributes"]).to have_key("name")
      expect(user_data["attributes"]).to have_key("email")
      expect(user_data["attributes"]).to have_key("api_key")

      attributes = user_data["attributes"]

      expect(attributes).to have_key("name")
      expect(attributes["name"]).to eq("Odell")
      expect(attributes).to have_key("email")
    end

    it "returns error if registration fails" do
      post "/api/v1/users", params: { name: "", email: "", password: "yes", password_confirmation: "yes" } 

      expect(response).to have_http_status(:unprocessable_entity)
      data = JSON.parse(response.body)
      expect(data).to_not have_key("data")
      expect(data).to have_key("errors")
      expect(data["errors"]).to eq(["Invalid credentials."])
    end

    it "returns error if email is already in the database" do
      user = User.create!(name: "Person1", email: "email.com", password: "yes", password_confirmation: "yes")
      post "/api/v1/users", params: { name: "Person2", email: "email.com", password: "yes", password_confirmation: "yes" } 

      expect(response).to have_http_status(:unprocessable_entity)
      data = JSON.parse(response.body)
      expect(data).to_not have_key("data")
      expect(data).to have_key("errors")
      expect(data["errors"]).to eq(["Email already exists."])
    end

    it "returns error if passwords do not match" do
      post "/api/v1/users", params: { name: "Fail", email: Time.now.to_i.to_s, password: "yes", password_confirmation: "no" } 

      expect(response).to have_http_status(:unprocessable_entity)
      data = JSON.parse(response.body)

      expect(data).to_not have_key("data")
      expect(data).to have_key("errors")
      expect(data["errors"]).to eq(["Password and password confirmation do not match."])
    end
  end
end
