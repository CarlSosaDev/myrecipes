class CommentsController < ApplicationController
    before_action :require_user

    def create
      @recipe = Recipe.find(params[:recipe_id])
      @chef = current_chef
      @comment = Comment.new(comment_params)
      @comment.chef = @chef
      @comment.recipe = @recipe
      if @comment.save()
        flash[:success] = 'Comment was created successfully';
        redirect_to recipe_path(@recipe)
      else
        flash[:danger] = 'Comment was not created';
        redirect_back(fallback_location: root_path)
      end
    end
private

  def comment_params()
     params.require(:comment).permit(:description)
  end
end
