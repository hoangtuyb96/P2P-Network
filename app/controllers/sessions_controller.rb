class SessionsController < Devise::SessionsController
  def new
  end

  def create
    user = User.find_by email: sign_in_params[:email]
    # if user && user.valid_password?(sign_in_params[:password])
    if user
      sign_in user
      flash[:success] = t("devise.sessions.signed_in")
      redirect_to root_path
    else
      flash[:danger] = t("devise.sessions.signed_in_failed")
      redirect_to root_path
    end
  end

  def destroy
    if user_signed_in?
      sign_out current_user
      redirect_to root_path
      flash[:success] = t("devise.sessions.signed_out")
    else
      redirect_to root_path
      flash[:danger] = t(".not_logged_in")
    end
  end

  private

  attr_accessor :user

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
