require "rails_helper"

RSpec.describe RecipeService do 
  before(:each) do 
    @service = RecipeService.new
  end

  describe "#recipe_search" do
    it "should return results based off a country" do
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