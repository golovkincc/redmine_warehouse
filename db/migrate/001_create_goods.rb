class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.decimal :price
      t.integer :count
      t.date :manufacture_date
      t.references :issue
    end
  end
end
