require "rails_helper"

RSpec.describe RecipeService do 
  before(:each) do 
    @service = RecipeService.new
  end

  describe "#recipe_search" do
    it "should return results based off a country" do
      json_data = File.read("spec/fixtures/recipes.json")
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{Rails.application.credentials.edamam[:app_id]}&app_key=#{Rails.application.credentials.edamam[:app_key]}&q=thailand&type=public").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.7.11'
           }).
         to_return(status: 200, body: json_data, headers: {})

      thailand_recipes = @service.recipe_search("thailand")

      thailand_recipes[:hits].each do |recipe|
        expect(recipe).to have_key(:recipe)
        expect(recipe[:recipe]).to have_key(:label)
        expect(recipe[:recipe]).to have_key(:url)
        expect(recipe[:recipe]).to have_key(:image)
      end
    end
  end
end