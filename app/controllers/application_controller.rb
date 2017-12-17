class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_logged_in
    unless user_signed_in?
      redirect_to login_path
      flash[:danger] = t("devise.failure.unauthenticated")
    end
  end
end
