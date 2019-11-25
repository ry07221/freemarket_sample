class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user,     null: false, foreign_key: true
      t.integer :customer_id

      t.timestamps
    end
  end
end
