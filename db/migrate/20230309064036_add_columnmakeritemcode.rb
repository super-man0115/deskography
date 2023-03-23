class AddColumnmakeritemcode < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :maker, :string
    add_column :items, :item_code, :string, null: false
  end
end
