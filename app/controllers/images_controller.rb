class ImagesController < ApplicationController
  before_action :check_logged_in
  before_action :check_admin, only: :destroy

  def show
    @image = Image.find_by id: params[:id]
    @comment = current_user.comments.new
  end

  def destroy
    @image = Image.find_by id: params[:id]
    if status.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private

  def check_admin
    unless current_user.is_admin
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end
end
