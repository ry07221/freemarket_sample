class CreateCredits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|
      t.references :user,     null: false, foreign_key: true
      t,string :customer_id,
      t.timestamps
    end
  end
end
