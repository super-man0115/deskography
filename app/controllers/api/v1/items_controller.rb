class Api::V1::ItemsController < ApplicationController
  include ActionController::RespondWith
  respond_to :json
  skip_before_action :require_login, only: %i[search]

  def new 
    @items = []
    if params[:keyword]
      results = RakutenWebService::Ichiba::Product.search({
        keyword: params[:keyword],
        hits: 10
      })

      results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
    end

    render '_search'
    
  end

  def create
    @item = Item.find_or_initialize_by(item_code: params[:item_code])

    unless @item.persisted?
      results = RakutenWebService::Ichiba::Product.search(productId: @item.item_code)
      @item = Item.new(read(results.first))
      @item.save
    end

    redirect_to new_post_path

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
      item_code: item_code,
      name: name,
      maker: maker,
      price: price,
      image: image,
      rakuten_url: rakuten_url,
      caption: caption,
    }
  end  
end