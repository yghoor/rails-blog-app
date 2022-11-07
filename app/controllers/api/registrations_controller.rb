class Api::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  skip_before_action :verify_authenticity_token, :only => :create
  # sign up
  def create
    user = User.new(user_params)
    user.skip_confirmation!
    if user.save
      render json: {
        messages: "Signed Up Successfully",
        is_success: true,
        data: {user: user}
      }, status: :ok
    else
      render json: {
        messages: "Sign Up Failed",
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return unless params.values_at(:name, :email, :password, :password_confirmation).include?(nil)
    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
      }, status: :bad_request
  end
end