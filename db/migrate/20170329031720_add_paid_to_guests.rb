class AddPaidToGuests < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :paid, :boolean
  end
end
