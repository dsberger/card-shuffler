class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.references :board, index: true, foreign_key: true
      t.integer :order_on_board

      t.timestamps null: false
    end
  end
end
