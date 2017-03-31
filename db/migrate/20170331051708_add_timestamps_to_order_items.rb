class AddTimestampsToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :created_at, :datetime
    add_column :order_items, :updated_at, :datetime
  end
end
