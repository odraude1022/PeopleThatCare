require 'faker'

User.destroy_all

user_list = [
  ["Eduardo", "Iglesias", "eriglesias@ufl.edu", "password", "password"],
  ["Rocio", "De Santiago", "rociodes4@hotmail.com", "password", "password"],
  ["Thayna", "Santana", "thaynamenezes01@gmail.com", "password", "password"],
  ["Gina", "De Santiago", "gina.gina@gina.gina", "password", "password"]
]
20.times do
  user_list.push([Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, 'password', 'password' ])
end

Charity.destroy_all

charity_list = [
  ["St. Jude", 620646012, "Jude", "stjude@stjude.com", "@stjude", "stjude.org", "password", "password"],
  ["Unesco", 12345, "John", "john@john.com", "@unesco", "unesco.org", "password", "password"],
  ["Eduardo's Charity", 99999, "Eduardo", "eduardo@charity.com", "@eduardo_charity", "eduardocharity.org", "password", "password"],
  ["Rocio's Charity", 123344, "Rocio", "rocio@charity.com", "@rocios_charity", "rociocharity.org", "password", "password"],
  ["Thayna's Charity", 876215, "Thayna", "thayna@charity.com", "@thaynas_charity", "thaynacharity.org", "password", "password"]
]

Category.destroy_all

category_list = ["Animals", "Education", "Environment", "Health", "Children", "Civil Rights", "Haiti"]

CharityCategory.destroy_all


NewsPost.destroy_all


user_list.each do |first_name, last_name, email, password, password_confirmation|
  User.create(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password_confirmation);
end

charity_list.each do |organization_name, tax_id, contact_name, contact_email, website_url, twitter_handle, password, password_confirmation|
  Charity.create(organization_name: organization_name, tax_id: tax_id, contact_name: contact_name, contact_email: contact_email, website_url: website_url, twitter_handle: twitter_handle, password: password, password_confirmation: password_confirmation)
end

news_post_list = []

50.times do
  news_post_list.push([Faker::Book.title, Faker::Books::Lovecraft.paragraph, Charity.all.sample.id])
end

category_list.each do |category_name|
  Category.create(category_name: category_name)
end

charity_category_list = []
10.times do
  charity_category_list.push([Charity.all.sample.id, Category.all.sample.id])
end

charity_category_list.each do |charity_id, category_id|
  CharityCategory.create(charity_id: charity_id, category_id: category_id)
end

news_post_list.each do |title, text, charity_id|
  NewsPost.create(title: title, text: text, charity_id: charity_id)
end

follow_list = []

User.all.each do |user|
  4.times do
    begin
      UserCharity.create(user_id: user.id, charity_id: Charity.all.sample.id)
    rescue
    end
  end
end
