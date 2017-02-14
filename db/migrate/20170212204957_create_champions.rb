class CreateChampions < ActiveRecord::Migration[5.0]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :champion_image
      t.integer :age
      t.text :story
      t.float :raised
      t.boolean :active, default: true
      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
