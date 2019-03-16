class NewsPostsController < ApplicationController

  def index
    if charity_logged_in?
      @news_posts = current_charity.news_posts
    elsif user_logged_in?
      user_charities = current_user.user_charities
      @charities = []
      user_charities.map do |user_charity|
        charity = Charity.find(user_charity.charity_id)
        @charities.push(charity)
      end
      @news_posts = []
      @charities.map do |charity|
        @news_posts.push(charity.news_posts.to_a)
      end
      @news_posts.flatten!
    end
  end

  def show
    @news_post = NewsPost.find(params[:id])
  end

  def new
    @news_post = NewsPost.new
  end

  def create
    @news_post= current_charity.news_posts.create(news_post_params)
    if @news_post.save
      redirect_to @news_post
    else
      render 'new'
    end
  end

  private

  def news_post_params
    params.require(:news_post).permit(:title, :text, :charity_id)
  end

end
