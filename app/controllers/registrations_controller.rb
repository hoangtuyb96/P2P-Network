class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_param

    if @user.save
      flash[:success] = t(".success")
      sign_in user
      redirect_to root_path
    else
      flash[:danger] = t(".failed")
      render :new
    end
  end

  private

  attr_reader :user

  def user_param
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end
end
