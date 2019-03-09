class CreateUserCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_charities do |t|

      t.timestamps
    end
  end
end
