class CommentsController < ApplicationController
  before_action :find_commentable, only: :create
  before_action :check_permission, only: :destroy

  def create
    @object = commentable
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

  def destroy
    if comment.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end    
  end

  private

  attr_reader :commentable, :comment

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

  def check_permission
    @comment = Comment.find_by id: params[:id]
    unless comment.user == current_user && comment.commentable.user == current_user
      flash[:danger] = "You can't delete this comment"
      redirect_to root_path
    end
  end
end
