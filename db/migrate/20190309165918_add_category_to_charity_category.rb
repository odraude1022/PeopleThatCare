class AddCategoryToCharityCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :charity_categories, :category, foreign_key: true
  end
end
