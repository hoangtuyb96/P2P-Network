class ImagesController < ApplicationController
  before_action :check_logged_in

  def show
    @image = Image.find_by id: params[:id]
    @comment = current_user.comments.new
  end
end
