class AddCharityToNewsPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :news_posts, :charity, foreign_key: true
  end
end
