class Api::PostsController < ApplicationController
  before_action :load_posts
  before_action :ensure_params_exist
  def index
    render json: @all_posts.to_json(only: [:id, :author_id, :title, :text, :comments_counter, :likes_counter])
  end

  private

  def load_posts
    @user = User.find(params[:user_id])
    @all_posts = @user.posts.all.order(created_at: :desc)
  end

  def ensure_params_exist
    return unless params.values_at(:user_id).include?(nil)

    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
      }, status: :bad_request
  end
end
