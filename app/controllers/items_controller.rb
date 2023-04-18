class ItemsController < ApplicationController
  include ActionController::RespondWith
  respond_to :html, :json
  skip_before_action :require_login, only: %i[search]

  def index
    @items = current_user.items
  end

  def search
    @items = []
    if params[:keyword].present?
      results = RakutenWebService::Ichiba::Product.search({
                                                            keyword: params[:keyword],
                                                            hits: 15
                                                          })

      results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
    else
      @items = []
      flash.now[:alert] = 'キーワードを入力してください'
    end

    render '_search'
  end

  def create
    @item = Item.find_or_initialize_by(item_code: params[:item_code])

    unless @item.persisted?
      results = RakutenWebService::Ichiba::Product.search(productId: @item.item_code)
      @item = Item.new(read(results.first))
      @item.save!
    end

    current_user.associate(@item)
    redirect_to items_path, notice: '商品を登録しました'
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end

  private

  def read(result)
    item_code = result['productId']
    name = result['productName']
    maker = result['makerName']
    price = result['averagePrice']
    image = result['mediumImageUrl'].gsub('?_ex=128x128', '')
    rakuten_url = result['affiliateUrl']
    caption = result['productCaption']

    {
      item_code:,
      name:,
      maker:,
      price:,
      image:,
      rakuten_url:,
      caption:
    }
  end
end
