class AddReferencesToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :chef
    add_reference :comments, :recipe
  end
end
