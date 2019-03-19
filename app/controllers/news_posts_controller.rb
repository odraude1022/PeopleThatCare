require 'link_thumbnailer'
class NewsPostsController < ApplicationController
  before_action :set_posts, only: [:index]

  def index
    respond_to do |format|
      format.html do
        page = (params[:page] || 1).to_i
        per_page = 5
        @news_posts = @news_posts.paginate(page: page, per_page: per_page)
      end
      format.json do
        page        = (params[:page] || 1).to_i
        per_page    = 5
        total_pages = (@news_posts.count.to_f / per_page).ceil
        total_pages = 1 if total_pages.zero?
        @news_posts      = @news_posts.paginate(page: page, per_page: per_page)
        render json: { news_posts: @news_posts, page: page, totalPages: total_pages }
      end
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

  def set_posts
    if charity_logged_in?
      @news_posts = current_charity.news_posts
    elsif user_logged_in?
      @news_posts = NewsPost.where(charity: current_user.charities)
    end
  end

  def news_post_params
    params.require(:news_post).permit(:title, :text, :url, :image, :charity_id)
  end

end
