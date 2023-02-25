class CommentBookmarksController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    current_user.comment_bookmark(@comment)
  end
  
  def destroy
    @comment = current_user.comment_bookmarks.find(params[:id]).comment
    current_user.comment_unbookmark(@comment)
  end
end
