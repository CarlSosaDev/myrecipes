class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end
  def new
    @recipe = Recipe.new()
  end
  def show()
    @recipe = Recipe.find(params[:id])
  end
  def create()
    @chef = Chef.first()
    @recipe = @chef.recipes.new(recipe_params())
    if @recipe.save()
      flash[:notice]="Recipe was successfully created"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  def edit()
    @recipe = Recipe.find(params[:id])
  end
  def update()
    @recipe = Recipe.find(params[:id])
    if @recipe.update( recipe_params())
    flash[:succes] = "Recipe was updated succesfully!"
    redirect_to(recipe_path(@recipe))
    else
     render 'edit'
    end
  end
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted succesfully"
    redirect_to recipes_path
  end
  private
  def recipe_params()
    params.require(:recipe).permit(:name, :description)
  end
end
