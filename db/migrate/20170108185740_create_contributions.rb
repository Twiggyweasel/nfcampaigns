class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.string :honoree
      t.sting :channel
      
      t.boolean :paid, default: false
      
      t.references :backable, polymorphic: true, index: true      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end