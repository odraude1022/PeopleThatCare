class NewsPostsController < ApplicationController
  def show
    @news_post = NewsPost.find(params[:id])
  end

  def new
    @news_post = NewsPost.new
  end

  def create
    @news_post= NewsPost.(news_post_params)
  end

  private

  def news_post_params
    params.require(:news_post).permit(:title, :text, :charity_id)
  end

end
