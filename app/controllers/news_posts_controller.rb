class NewsPostsController < ApplicationController

  def index
    @news_posts = NewsPost.all.where(charity_id: current_charity[:id])
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
