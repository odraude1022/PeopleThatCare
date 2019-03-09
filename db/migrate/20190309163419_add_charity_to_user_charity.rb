class AddCharityToUserCharity < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_charities, :charity, foreign_key: true
  end
end
