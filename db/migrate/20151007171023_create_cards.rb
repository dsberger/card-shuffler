class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.references :list, index: true, foreign_key: true
      t.integer :order_on_list
      t.string :color

      t.timestamps null: false
    end
  end
end
