class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.string :name,  null: false, index: true
      t.timestamps
    end
  end
end
