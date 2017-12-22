class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :index_notifications

  def check_logged_in
    unless user_signed_in?
      redirect_to login_path
      flash[:danger] = t("devise.failure.unauthenticated")
    end
  end

  def index_notifications
    if user_signed_in?
      @notifications = current_user.notifications.limit(15)
    end
  end
end
