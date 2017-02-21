class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_cover
      t.string :event_card
      t.string :event_type 
      t.string :gallery
      t.text :teaser
      t.text :desc
      t.date :registration_date
      t.date :event_date
      t.time :event_start_time
      t.time :event_end_time
      t.float :goal
      t.float :raised
      t.string :venue_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.boolean :has_shirts, default: true
      t.boolean :is_private, default: true

      t.timestamps
    end
  end
end
