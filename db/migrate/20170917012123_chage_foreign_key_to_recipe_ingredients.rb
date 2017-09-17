class ChageForeignKeyToRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    change_column :recipe_ingredients, :ingredient_id, :bigint
    change_column :recipe_ingredients, :recipe_id, :bigint
  end
end
