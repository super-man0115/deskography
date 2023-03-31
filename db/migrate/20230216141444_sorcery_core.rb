class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :email, index: { unique: true }
      t.string :crypted_password
      t.string :salt

      t.timestamps                null: false
    end
  end
end
