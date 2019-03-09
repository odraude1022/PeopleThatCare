class CreateCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :organization_name
      t.string :tax_id
      t.string :contact_name
      t.string :contact_email
      t.string :twitter_handle

      t.timestamps
    end
  end
end
