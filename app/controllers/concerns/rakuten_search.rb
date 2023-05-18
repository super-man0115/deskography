module RakutenSearch
  extend ActiveSupport::Concern

  # RakutenApiを使用して商品を検索する。検索結果を@itemsに代入する。readというプライベートメソッドで商品データを読み取り扱いやすいハッシュに変換している
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

  # 指定したitem_codeを持つ商品が存在する場合はその値を取得し、存在しない場合はRakutenApiを使用して商品を検索し、@itemに代入する。associateメソッドでcurrent_userと@itemを関連付ける
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
