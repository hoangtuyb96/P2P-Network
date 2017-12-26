class SearchController < ApplicationController
  def search
    if params[:search][:q].nil?
      @groups = []
      @users = []
    else
      @groups = Group.search params[:search][:q]
      @users = User.search params[:search][:q]
    end
  end
end
