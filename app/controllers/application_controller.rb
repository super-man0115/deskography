class ApplicationController < ActionController::Base
  before_action :require_login

  def current_user
    @current_user ||= login_from_session
  end

  def check_user
    return if @user == current_user

    redirect_to user_path(@user), alert: '権限がありません'
  end

  def check_post
    return if @post.user == current_user

    redirect_to post_path(@post), alert: '権限がありません'
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "ログインが必要です"
  end  
end
