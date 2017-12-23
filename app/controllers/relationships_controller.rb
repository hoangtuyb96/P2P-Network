class RelationshipsController < ApplicationController
  before_action :check_logged_in, only: %i(index create destroy)
  before_action :find_relationship_to_destroy, only: :destroy
  before_action :find_accepter, only: %i(create destroy)

  def following
    @following = current_user.request_sending_friend
  end

  def follower
    @follower = current_user.request_accept_friend
  end

  def create
    @relationship = Relationship.new
    relationship.sender_id = params[:sender_id]
    relationship.accepter_id = params[:accepter_id]
    if relationship.save
      follow_notification
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path
      flash[:danger] = "Can't follow now, please try again"
    end
  end

  def destroy
    if relationship.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      redirect_to root_path
      flash[:danger] = "Can't unfollow now, please try again"
    end
  end

  private

  attr_reader :relationship

  def find_relationship_to_destroy
    @relationship =
      Relationship.find_relationship(params[:sender_id], params[:accepter_id]).first
  end

  def find_accepter
    @user = User.find_by id: params[:accepter_id]
  end

  def follow_notification
    NotificationWhenBeFollowedService.new(sender: current_user, accepter: @user).perform
  end
end
