class StatusesController < ApplicationController
  before_action :check_logged_in, only: %i(new create)

  def index
    @statuses = Status.all.page(params[:page]).per(5)
    @groups = current_user.group_joined
  end

  def new
    @status = current_user.statuses.new
  end

  def create
    @status = current_user.statuses.new status_params
    if status.save
      flash[:success] = t(".success")
      redirect_to root_path
    else
      flash[:danger] = t("fail")
      render :new
    end
  end

  private

  attr_reader :status, :statuses

  def status_params
    params.require(:status).permit Status::ATTRIBUTES_PARAMS,
      images_attributes: %i(link _destroy)
  end
end
