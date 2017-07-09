class CreateVolunteers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :email
      t.string :shirt_size
      t.string :volunteer_type
      t.string :group_name

      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
