class StatusesController < ApplicationController
  before_action :check_logged_in, only: %i(new create)
  before_action :status_on_wall, only: :index

  def index
    @statuses = @statuses.paginate(:page => params[:page], :per_page => 15)
    @groups = current_user.group_joined
    @comment = current_user.comments.new
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

  def status_on_wall
    @statuses = []
    @statuses += current_user.statuses
    current_user.request_sending_friend.each do |user|
      @statuses += user.statuses
    end
    @statuses = @statuses.sort_by(&:updated_at).reverse
  end

  def status_params
    params.require(:status).permit Status::ATTRIBUTES_PARAMS,
      images_attributes: %i(link _destroy)
  end
end
