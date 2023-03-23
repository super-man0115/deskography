class CreatePostItems < ActiveRecord::Migration[7.0]
  def change
    create_table :post_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :post_items, [:item_id, :post_id], unique: true
  end
end
