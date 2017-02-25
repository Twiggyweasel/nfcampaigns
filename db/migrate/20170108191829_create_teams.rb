class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :team_photo
      t.float :goal
      t.integer :max_members
      t.float :raised
      t.boolean :is_private, default: false
      
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
