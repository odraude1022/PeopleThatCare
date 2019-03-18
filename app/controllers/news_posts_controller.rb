require 'link_thumbnailer'
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
    params = news_post_params
    url = params[:url]
    charity_id = params[:charity_id]
    if url == ''
      title = params[:title]
      text = params[:text]
      @news_post = current_charity.news_posts.new(title: title, text: text, charity_id: charity_id)
      if @news_post.save
        redirect_to @news_post
      else
        render 'new'
      end
    else
      begin 
        object = LinkThumbnailer.generate(url)
        title = object.title
        image = object.images.first.src.to_s
        text = url
      rescue 
      end
      @news_post = current_charity.news_posts.new(title: title, text: text, image: image, charity_id: charity_id)
      if @news_post.save
        redirect_to @news_post
      else
        redirect_back fallback_location: "/", alert: "Invalid url, please try again"
      end
    end
  end

  private

  def news_post_params
    params.require(:news_post).permit(:title, :text, :url, :image, :charity_id)
  end

end
