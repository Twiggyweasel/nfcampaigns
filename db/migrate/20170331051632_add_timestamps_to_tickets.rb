class AddTimestampsToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :created_at, :datetime
    add_column :tickets, :updated_at, :datetime
  end
end
