class CreateNewsPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :news_posts do |t|
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
