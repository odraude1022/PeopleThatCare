class CreateCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :organization_name, null: false
      t.string :tax_id, null: false
      t.string :contact_name, null: false
      t.string :contact_email, null: false
      t.string :twitter_handle

      t.timestamps
    end
  end
end
