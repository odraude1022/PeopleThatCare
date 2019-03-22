class Twitter < ApplicationRecord

  def initialize(twitter_handle)
    @twitter_handle = twitter_handle
  end
  
  #Tweets by username
  def get_tweets
    $TWITTER_CLIENT.search("from:#{Charity.id.twitter_handle}", result_type: "recent").take(5).map do |tweet|
      tweet.text
    end
  end

  def twitter_timeline 
    tweets = $TWITTER_CLIENT.user_timeline('rubyinside', count: 2)
  end

  def twitter_profile
    @user_timeline = $TWITTER_CLIENT.user_timeline(charity_id.twitter_handle)
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
