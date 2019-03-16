class AddUniqueIndexToUserCharity < ActiveRecord::Migration[5.2]
  def change
    add_index :user_charities, [:user_id, :charity_id], unique: true
  end
end
