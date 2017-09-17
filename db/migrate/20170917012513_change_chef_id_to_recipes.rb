class ChangeChefIdToRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :chef_id,:bigint
  end
end
