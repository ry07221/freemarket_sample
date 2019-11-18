class CreateDealings < ActiveRecord::Migration[5.1]
  def change
    create_table :dealings do |t|
      t.integer: phase,  default: 0
      t.references :item,  null: false, foreign_key: true
      t.references :user,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
