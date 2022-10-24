class PostsController < ApplicationController
  POSTS_PER_PAGE = 2

  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 0).to_i
    @user_posts = @user.posts.all.order(created_at: :desc).offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.new(post_params)
    post.author = current_user
    if post.save
      flash[:success] = 'Post saved successfully'
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new, locals: { post: @post }
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  private

  def post_params
    params.require(user_posts_url).permit(:title, :text)
  end
end
