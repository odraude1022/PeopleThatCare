class AddRememberDigestToCharities < ActiveRecord::Migration[5.2]
  def change
    add_column :charities, :remember_digest, :string
  end
end
