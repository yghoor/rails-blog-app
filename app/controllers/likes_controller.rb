class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)

    Like.create(author: current_user, post: @post)
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
