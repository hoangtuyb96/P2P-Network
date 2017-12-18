class GroupsController < ApplicationController
  before_action :check_logged_in, only: %i(new create)

  def new
    @group = Group.new
  end

  def create
    @group = Group.new group_params
    if group.save
      binding.pry
      @group_member = group.group_members.new
      group_member.user_id = current_user.id
      group_member.permission = 2
      if group_member.save
        flash[:success] = "success"
        redirect_to root_path
      else
        flash[:danger] = "fail"
        redirect_to root_path
      end
    else
      flash[:danger] = "fail"
      redirect_to root_path      
    end
  end

  private

  attr_reader :group, :group_member
  
  def group_params
    params.require(:group).permit Group::ATTRIBUTES_PARAMS
  end
end
