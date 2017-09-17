class DeleteChefAndRecipeFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :chef_id
    remove_column :comments, :recipe_id
  end
end
