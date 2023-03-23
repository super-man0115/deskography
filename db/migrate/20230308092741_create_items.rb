class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.string :price
      t.string :rakuten_url
      t.text :caption

      t.timestamps
    end
  end
end
