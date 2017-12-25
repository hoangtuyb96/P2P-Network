class StatusesController < ApplicationController
  before_action :check_logged_in, only: %i(new create destroy)
  before_action :status_on_wall, only: :index
  before_action :find_status, only: :destroy
  before_action :check_permission, only: :destroy

  def index
    @statuses = @statuses.paginate(:page => params[:page], :per_page => 15)
    @groups = current_user.group_joined
    @comment = current_user.comments.new
    @status = current_user.statuses.new
  end

  def new
    @status = current_user.statuses.new
  end

  def create
    @status = current_user.statuses.new status_params
    @status.group_id = params[:group_id]
    if status.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    else
      flash[:danger] = "Fail"
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  def destroy
    if status.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private

  attr_reader :status, :statuses

  def find_status
    @status = Status.find_by id: params[:id]
  end

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

  def check_permission
    unless status.user == current_user
      flash[:danger] = "You can't delete this status."
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end
end
