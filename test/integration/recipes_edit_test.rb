require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name:"Carlos Sosa",email:"c.sosa@gmail.com")
    @recipe = Recipe.create(name:"Bacon Hamburger",description:"Bread,Bacon, meat and vegetable",chef: @chef)
  end

  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params:{recipe: {name:"", description:"Some description"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "succesfully edit a " do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params:{recipe: {name:updated_name, description: updated_description }}
    assert_redirected_to @recipe
    #follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name,@recipe.name
    assert_match updated_description, @recipe.description

  end
  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe),text:"Edit this recipe"
    assert_select 'a[href=?]',recipe_path(@recipe),text:"Delete this recipe"
  end
end
