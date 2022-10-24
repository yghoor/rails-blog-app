class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
  end

end
