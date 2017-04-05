class CreateSponsorships < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsorships do |t|
      t.string :name
      t.string :logo
      t.float :fee
      t.integer :quantity
      t.boolean :paid, default: true
      
      t.references :event, foreign_key: true
      t.references :ticket, foreign_key: true
      t.references :sponsor_level, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
