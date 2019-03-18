class CreateNewsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :news_posts do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.string :url
      t.string :image
      t.references :charity, foreign_key: true, null: false

      t.timestamps
    end
  end
end
