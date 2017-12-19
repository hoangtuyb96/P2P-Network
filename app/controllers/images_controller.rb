class ImagesController < ApplicationController
  before_action :check_logged_in

  def show
    @image = Image.find_by id: params[:id]
  end
end
