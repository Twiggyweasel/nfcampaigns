class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :event_type
      t.string :city
      t.string :state
      t.text :comments
      
      t.timestamps
    end
  end
end
