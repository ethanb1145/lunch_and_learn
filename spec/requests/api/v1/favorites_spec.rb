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
end
