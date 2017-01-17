class CreateGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :guests do |t|
      t.string :name
      t.decimal :fee
      t.string :shirt_size
      t.string :email
      
      t.references :attendee, foreign_key: true
      t.timestamps
    end
  end
end
