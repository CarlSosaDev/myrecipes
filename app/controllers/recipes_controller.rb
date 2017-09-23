class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update, :like]
  before_action :require_user, except: [:index,:show, :like]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  before_action :require_user_like, only: [:like]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def new
    @recipe = Recipe.new()
  end

  # @pre: call set_recipe()
  def show
    @comment = Comment.new()
    @comments = @recipe.comments.paginate(page: params[:page],per_page: 5)
  end

  def create
    @chef = current_chef
    @recipe = @chef.recipes.new(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe was successfully created';
      redirect_to(recipe_path( @recipe ))
    else
      render 'new';
    end
  end

  def edit
    # set_recipe()
  end

  def update
    # set_recipe()
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe was updated succesfully!';
      redirect_to(recipe_path(@recipe))
    else
      render 'edit';
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = 'Recipe deleted succesfully';
    redirect_to recipes_path
  end
  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was succesfully created"
    else
      flash[:danger]= "You can only like/dislike a recipe one"
      redirect_back(fallback_location: recipes_path)
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    @recipe = set_recipe
      if current_chef != @recipe.chef and !current_chef.admin?
       flash[:danger] = 'You can only edit or delete you own recipes';
       redirect_to recipes_path
      end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image,ingredient_ids: [])
  end

  def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_back(fallback_location: recipes_path)
      end
  end
end
