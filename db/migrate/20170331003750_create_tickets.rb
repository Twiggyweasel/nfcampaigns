class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.float :fee
      t.date :date_available
      t.integer :quantity
      t.integer :sold
      t.boolean :is_soldout, default: false
      t.references :event, foreign_key: true
    end
  end
end
