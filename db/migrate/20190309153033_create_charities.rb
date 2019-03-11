class CreateCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :organization_name, null: false
      t.integer :tax_id, null: false
      t.string :contact_name, null: false
      t.string :contact_email, null: false
      t.string :twitter_handle
      t.string :website_url, null:false

      t.timestamps
    end
    add_index :charities, :contact_email, unique: true
  end
end
