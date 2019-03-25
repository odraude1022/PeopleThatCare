require 'link_thumbnailer'
require 'twitter'

class NewsPostsController < ApplicationController
  before_action :set_posts, only: [:index]
  before_action :set_post, only: [:destroy]

  def index
    page        = (params[:page] || 1).to_i
    per_page    = 10
    total_pages = (@news_posts.count.to_f / per_page).ceil
    total_pages = 1 if total_pages.zero?
    @news_posts = @news_posts.order(created_at: :desc).paginate(page: page, per_page: per_page)
    respond_to do |format|
      format.html
      format.json do
        render json: { news_posts: @news_posts, page: page, totalPages: total_pages }
      end
    end

      if user_logged_in?
        @twitter_handle = current_charity ? current_charity.twitter_handle.gsub('@', '') : 'hello'
        @charities_tweets = current_user.charities.map do |charity|
          begin 
            $TWITTER_CLIENT.user_timeline(charity.twitter_handle)
          rescue 
          end
        end
      elsif charity_logged_in?
        @twitter_handle = current_charity ? current_charity.twitter_handle.gsub('@', '') : 'hello'
        @charities_tweets = $TWITTER_CLIENT.user_timeline(current_charity.twitter_handle)
      end

    #this sorts the tweets
    @charities_tweets.flatten!
    @charities_tweets.compact!
    @charities_tweets = @charities_tweets.sort_by do |tweet| 
      tweet.created_at if tweet && tweet.created_at
    end 
    @charities_tweets.reverse!
    @charities_tweets = @charities_tweets[0,27]
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
        text = object.description + "\n Follow this link to read more - " + url
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

  def destroy
    @news_post.destroy
    redirect_back fallback_location: "/", notice: 'News Post was successfully deleted!'
  end

  private

  def set_posts
    if charity_logged_in?
      @news_posts = current_charity.news_posts
    elsif user_logged_in?
      @news_posts = NewsPost.where(charity: current_user.charities)
    end
  end

  def set_post
    @news_post = current_charity.news_posts.find(params[:id])
  end

  def news_post_params
    params.require(:news_post).permit(:title, :text, :url, :image, :charity_id)
  end
end
