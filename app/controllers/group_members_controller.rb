class GroupMembersController < ApplicationController
  def create
    @group_member = GroupMember.new
    group_member.user_id = params[:user_id]
    group_member.group_id = params[:group_id]
    if group_member.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private

  attr_reader :group_member
end
