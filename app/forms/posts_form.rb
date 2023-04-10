class PostsForm
  include ActiveModel::Attributes

  attribute :items
  attribute :items1
  attribute :items2
  attribute :items3
  attribute :items4
  attribute :items5
  attribute :items6
  attribute :items7
  attribute :items8

  def initialize(attributes = {}, post: Post.new)
    @post = post
    new_attributes = default_attributes.merge(attributes)
    super(new_attributes)
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      post = Post.new(post_params)
      post.save!

      items_params&.each do |item|
        h_item = eval(item) # evalmメソッドはセキュリティホール的に非推奨なので早急に修正
        new_item = Item.new(h_item)

        if Item.exists?(item_code: h_item[:item_code])
          exist_item = Item.find_by(item_code: h_item[:item_code])
          post.item_tags.create!(item_id: exist_item.id)
        else
          new_item.save!
          post.item_tags.create!(item_id: new_item.id)
        end
      end
    end

    true
  end 
end  