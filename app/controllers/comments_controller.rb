class CommentsController < ApplicationController
  before_action :find_commentable, only: :create

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
       format.js
       format.html { redirect_to root_path }
     end
    else
      flash[:danger] = "Post comment failed"
      redirect_to root_path
    end
  end

  private

  attr_reader :commentable

  def comment_params
    params.require(:comment).permit Comment::ATTRIBUTES_PARAMS
  end

  def find_commentable
    if params[:commentable_type] == "Status"
      @commentable = Status.find_by id: params[:commentable_id]
    else
      @commentable = Image.find_by id: params[:commentable_id]
    end
  end
end
