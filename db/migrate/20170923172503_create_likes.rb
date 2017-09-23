class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.references :chef
      t.references :recipe
      t.timestamps
    end
  end
end
