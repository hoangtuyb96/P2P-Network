class UsersController < ApplicationController
  before_action :find_user, only: %i(show update)
  before_action :check_permission, only: :update

  def show
  end

  def update
    if user.update_attributes user_params
      redirect_to :user
      flash[:success] = "Success"
    else
      redirect_to :user
      flash[:fail] = "Fail"
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS_UPDATE
  end

  def find_user
    @user = User.find_by id: params[:id]
  end

  def check_permission
    unless user == current_user
      redirect_to root_path
      flash[:fail] = "You don't have a permission to do"
    end
  end
end
