class BookmarksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @bookmark = current_user.bookmark(@post)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @post = current_user.bookmarks.find(params[:id]).post
    current_user.unbookmark(@post)
  end
end
