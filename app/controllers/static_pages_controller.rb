class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def index; end
  def privacy; end
  def term; end
end
