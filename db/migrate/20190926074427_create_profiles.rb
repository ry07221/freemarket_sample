class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name,         null: false
      t.string :last_name,          null: false
      t.string :first_name_kana,    null: false
      t.string :last_name_kana,     null: false
      t.integer :tell
      t.integer :postal_code,       ull: false
      t.integer :prefecture,        null: false
      t.string :city,               null: false
      t.string :address_number,     null: false
      t.string :building
      t.text :introduction
      t.string :avatarstring
      t.integer :birthday,          null: false
      t.string  :gender,            null: false
      t.references :user,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
