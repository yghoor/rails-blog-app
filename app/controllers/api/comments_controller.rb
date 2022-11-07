class Api::CommentsController < ApplicationController
  before_action :load_comments

  def index
    render json: @comments
  end

  private

  def load_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc)
  end
end
