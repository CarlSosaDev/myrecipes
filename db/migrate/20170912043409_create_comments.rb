class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :chef_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
=begin
Primero sacar chef:
 chef = Chef.first()

 segundo sacar recipe:
   recipe = Recipe.first()

   tercero crear commentario y pasar objects anteriores
   comment = Comment.create(description:'',chef: chef, recipe: recipe)

   cuarto consultar (utilizando obujectos asociados a comentario)
   recipe.comments
   chef.comments

=end
