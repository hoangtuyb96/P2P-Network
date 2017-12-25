class GroupsController < ApplicationController
  before_action :check_logged_in, only: %i(index new create)
  before_action :find_group, only: :show

  def index
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new group_params
    if group.save
      @group_member = group.group_members.new
      group_member.user_id = current_user.id
      group_member.permission = 2
      if group_member.save
        flash[:success] = "Success"
        redirect_to user_statuses_path(current_user)
      else
        flash[:danger] = "Fail"
        redirect_to root_path
      end
    else
      flash[:danger] = "Fail"
      redirect_to root_path      
    end
  end

  def show
    @group = Group.find_by id: params[:id]
    @statuses = @group.statuses
    @comment = current_user.comments.new
    @status = current_user.statuses.new
  end

  private

  attr_reader :group, :group_member
  
  def group_params
    params.require(:group).permit Group::ATTRIBUTES_PARAMS
  end

  def find_group
    @group = Group.find_by id: params[:id]
  end
end
