class CreateSponsorLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsor_levels do |t|
      t.string :name
      t.text :desc
      t.float :price
      t.integer :quantity
      t.references :event, foreign_key: true
      t.references :ticket, foreign_key: true
    end
  end
end
