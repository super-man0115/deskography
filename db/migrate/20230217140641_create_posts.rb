class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :business_attribute, null: false, default: 0
      t.integer :age_group, null: false, default: 0

      t.timestamps
    end
  end
end
