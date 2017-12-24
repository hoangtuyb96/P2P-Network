class UsersController < ApplicationController
  before_action :check_logged_in
  before_action :find_user, only: %i(show edit update destroy)
  before_action :check_permission, only: %i(edit update destroy)

  def show
    @status = current_user.statuses.new
    @comment = current_user.comments.new
  end

  def edit
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

  def destroy
    if user.destroy
      flash[:success] = "Destroy successfully"
      redirect_to root_path
    else
      flash[:fail] = "Destroy fail"
      redirect_to :user
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
