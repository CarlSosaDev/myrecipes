require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
   test "should get recipes index" do
     get recipes_url
     assert_response :success
   end
   test "reject invalid recipe submissions " do
      get new_recipe_path
      assert_template 'recipes/new'
      assert_no_difference 'Recipe.count' do
         post recipes_path, params: {recipe: {name:"",description:""}}
      end
      assert_template 'recipes/new'
      assert_select 'h2.panel-title'
      assert_select 'div.panel-bodyexit'
   end
end
