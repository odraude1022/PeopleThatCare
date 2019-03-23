class TwittersController < ApplicationController 
  #Tweets by username
  def show
    $TWITTER_CLIENT.search("from:#{current_charity.twitter_handle}", result_type: "recent").take(5).map do |tweet|
      tweet.text
    end
  end
  def index 
    @twitter_handle = current_charity.twitter_handle.gsub('@', '')
    @url = "https://twitter.com/#{@twitter_handle}?ref_src=twsrc%5Etfw"
    p @twitter_handle 
    p 'hello world'
    tweets = $TWITTER_CLIENT.user_timeline('rubyinside', count: 2)
  end

  def twitter_profile
    @user_timeline = $TWITTER_CLIENT.user_timeline(current_charity.twitter_handle)
    @home_timeline = $TWITTER_CLIENT.home_timeline
  end

  def update_user_account
    user_twitter_profile = $TWITTER_CLIENT.user
    current_user.update_attributes({
      name: user_twitter_profile.name,
      screen_name: user_twitter_profile.screen_name,
      url: user_twitter_profile.url,
      profile_image_url: user_twitter_profile.profile_image_url,
      location: user_twitter_profile.location, 
      description: user_twitter_profile.description
  })
  end
end 
