class GroupMembersController < ApplicationController
  before_action :find_request, only: %i(update destroy)

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

  def update
    request_join.permission = 1
    if request_join.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  def destroy
    if request_join.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private

  attr_reader :group_member, :request_join

  def find_request
    @request_join = GroupMember.find_by id: params[:id]
  end
end
