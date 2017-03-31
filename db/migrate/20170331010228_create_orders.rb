class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.boolean :paid, defaultL false
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
