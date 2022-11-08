class Api::CommentsController < ApplicationController
  before_action :load_comments
  before_action :ensure_params_exist, only: :create

  def index
    render json: {
      messages: 'Posts loaded successfully',
      is_success: true,
      data: { comments: @comments.to_json(only: %i[id author_id post_id text]) }
    }, status: :ok
  end

  def create
    comment = Comment.new(author_id: comment_params[:user_id], post_id: comment_params[:post_id],
                          text: comment_params[:text])

    if comment.save
      render json: {
        messages: 'Comment created successfully',
        is_success: true,
        data: { comment: comment.to_json(only: %i[id author_id post_id text]) }
      }, status: :ok
    else
      render json: {
        messages: 'Comment creation failed',
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end

  private

  def load_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc)
  end

  def comment_params
    params.permit(:user_id, :post_id, :text)
  end

  def ensure_params_exist
    return unless params.values_at(:user_id, :post_id, :text).include?(nil)

    render json: {
      messages: 'Missing Params',
      is_success: false,
      data: {}
    }, status: :bad_request
  end
end
