class AddCharityToCharityCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :charity_categories, :charity, foreign_key: true
  end
end
