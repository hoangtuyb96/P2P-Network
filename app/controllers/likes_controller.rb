class LikesController < ApplicationController
  before_action :check_logged_in
  before_action :find_status

  def create
    @like = current_user.likes.new 
    like.likeable_id = params[:likeable_id]
    like.likeable_type = params[:likeable_type]
    if like.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy
    @like = Like.find_like(params[:likeable_id],
      params[:likeable_type], current_user.id).first
    if like.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  attr_reader :like

  def find_status
    if params[:likeable_type] == "Status"
      @object = Status.find_by id: params[:likeable_id]
    else
      @object = Image.find_by id: params[:likeable_id]
    end
  end
end
