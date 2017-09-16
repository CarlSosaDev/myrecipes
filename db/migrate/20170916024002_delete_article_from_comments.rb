class DeleteArticleFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comemnts, :articles
  end
end
