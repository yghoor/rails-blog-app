class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)

    if @like.save
      flash[:success] = 'Like added successfully'
    else
      flash.now[:error] = 'Error: Like could not be saved'
    end
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
