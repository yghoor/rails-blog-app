class PostsController < ApplicationController
  POSTS_PER_PAGE = 2

  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 0).to_i
    @user_posts = @user.posts.all.order(created_at: :desc).offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
