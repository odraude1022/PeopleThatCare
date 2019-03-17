class AddUniqueIndexToCharityCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :charity_categories, [:charity_id, :category_id], unique: true
  end
end
