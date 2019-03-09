class AddPasswordDigestToCharities < ActiveRecord::Migration[5.2]
  def change
    add_column :charities, :password_digest, :string
  end
end
