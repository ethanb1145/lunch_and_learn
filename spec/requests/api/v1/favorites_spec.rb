require "rails_helper"

RSpec.describe "Favorites API", type: :request do
  describe "POST /api/v1/favorites" do
    it "creates a new favorite" do
      User.create!(
        name: "User",
        email: "user.com",
        password: "password",
        password_confirmation: "password",
        api_key: "jgn983hy48thw9begh98h4539h4"
      )

      post "/api/v1/favorites", params: {
        api_key: "jgn983hy48thw9begh98h4539h4",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }

      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data["success"]).to eq(["Favorite added successfully."])
    end

    it "returns error if favorite creation fails" do
      User.create!(
        name: "User",
        email: "user.com",
        password: "password",
        password_confirmation: "password",
        api_key: "jgn983hy48thw9begh98h4539h4"
      )

      post "/api/v1/favorites", params: {
        api_key: "jgn983hy48thw9begh98h4539h4",
        country: "thailand",
        recipe_link: "", 
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }

      expect(response).to have_http_status(:unprocessable_entity)
      data = JSON.parse(response.body)
      expect(data["error"]).to eq(["Favorite not added. Fill in all fields."])
    end

    it "returns error if api_key is invalid" do
      post "/api/v1/favorites", params: {
        api_key: "invalid_api_key",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }

      expect(response).to have_http_status(400)
      data = JSON.parse(response.body)
      expect(data["error"]).to eq(["Invalid Api-Key."])
    end
  end

  describe "GET /api/v1/favorites" do
    it "returns favorites for a specific user" do
      user = User.create!(
        name: "User",
        email: "user.com",
        password: "password",
        password_confirmation: "password",
        api_key: "jgn983hy48thw9begh98h4539h4"
      )

      favorite1 = Favorite.create(user: user, recipe_title: "Recipe: Egyptian Tomato Soup", recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....", country: "egypt", created_at: "2022-11-02T02:17:54.111Z")
      favorite2 = Favorite.create(user: user, recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", recipe_link: "https://www.tastingtable.com/.....", country: "thailand", created_at: "2022-11-07T03:44:08.917Z")

      get "/api/v1/favorites", params: { api_key: user.api_key }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      
      expected_response = {
        "data" => [
          {
            "id" => favorite1.id.to_s,
            "type" => "favorite",
            "attributes" => {
              "country" => "egypt",
              "recipe_link" => favorite1.recipe_link,
              "recipe_title" => favorite1.recipe_title,
              "created_at" => favorite1.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
            }
          },
          {
            "id" => favorite2.id.to_s,
            "type" => "favorite",
            "attributes" => {
              "country" => "thailand",
              "recipe_link" => favorite2.recipe_link,
              "recipe_title" => favorite2.recipe_title,
              "created_at" => favorite2.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
            }
          }
        ]
      }

      expect(json_response).to eq(expected_response)
    end

    it "returns an empty array if the user has no favorites" do
      user = User.create!(
        name: "User",
        email: "user.com",
        password: "password",
        password_confirmation: "password",
        api_key: "jgn983hy48thw9begh98h4539h4"
      )

      get "/api/v1/favorites", params: { api_key: user.api_key }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)

      expect(json_response["data"]).to eq([])
    end

    it "returns an error if the api_key is invalid" do
      get "/api/v1/favorites", params: { api_key: "invalid_api_key" }

      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)

      expect(json_response["error"]).to eq(["Invalid Api-Key."])
    end
  end
end