class AddEventsToChampions < ActiveRecord::Migration[5.0]
  def change
    add_reference :champions, :event, foreign_key: true
  end
end
