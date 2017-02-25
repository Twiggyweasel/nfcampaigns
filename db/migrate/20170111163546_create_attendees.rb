class CreateAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :attendees do |t|
      t.float :fee
      t.string :shirt_size
      t.string :business_name
      t.string :category
      t.integer :guest_limit
      
      t.boolean :paid, default: false
      t.boolean :is_leader, default: false
      
      t.float :raised
      
      t.references :team, foreign_key: true
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
