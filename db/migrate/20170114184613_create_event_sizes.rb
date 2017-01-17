class CreateEventSizes < ActiveRecord::Migration[5.0]
  def change
    create_table :event_sizes do |t|
      t.references :size, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
