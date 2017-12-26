class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update 
  before_action :check_logged_in
  before_action :find_group, only: %i(show edit update destroy)
  before_action :find_group_member, only: %i(show edit update destroy)

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
    @statuses = @group.statuses
    @comment = current_user.comments.new
    @status = current_user.statuses.new
  end

  def edit
  end

  def update
    if group.update_attributes group_params
      flash[:success] = "Updated successfully"
      render :edit
    else
      flash[:danger] = "Can't update info group now"
      render :edit
    end
  end

  def destroy
    if group.destroy
      flash[:success] = "Deleted successfully"
      redirect_to user_statuses_path(current_user)
    else
      flash[:danger] = "Can't delete group"
      render :edit
    end
  end

  def requests
    @group = Group.find_by id: params[:group_id]
    @requests = GroupMember.find_requests(@group.id)
  end

  private

  attr_reader :group, :group_member
  
  def group_params
    params.require(:group).permit Group::ATTRIBUTES_PARAMS
  end

  def find_group
    @group = Group.find_by id: params[:id]
  end

  def find_group_member
    @gm = GroupMember.find_group_member(current_user.id, @group.id).first
  end

  def check_admin_group
    unless @gm.permission == 2
      flash[:danger] = "You can't setting this group"
      redirect_to user_statuses_path(current_user)
    end
  end
end
