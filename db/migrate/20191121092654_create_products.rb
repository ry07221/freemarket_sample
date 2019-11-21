class CreateProducts < ActiveRecord::Migration[5.1]

  def change

    create_table :products do |t|
      t.string :name,                index: true, null: false
      t.text :detail,                null:false
      t.integer :shipping_fee_payer, null:false
      t.integer :shipping_fee
      t.integer :shipping_method,    null:false 
      t.integer :expected_date,      null:false
      t.integer :price,              index: true, null: false
      t.integer :like_count,         default: 0
      t.string :status,              null: false
      t.string :size
      t.integer :transaction_status, null: false, default: 0
      t.integer :purchaser_id
      t.references :user,            null: false, foreign_key: true
      t.references :category, null:false,forign_key: true
      t.integer    :delivery_agency, null:false    ## 配送元地域

      t.timestamps
    end
      
  end

end

