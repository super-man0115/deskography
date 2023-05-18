class ItemsController < ApplicationController
  include ActionController::RespondWith
  include RakutenSearch
  respond_to :html, :json
  skip_before_action :require_login, only: %i[search]

  def index
    @items = current_user.items
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end
end
