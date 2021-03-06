class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.float :amount
      t.string :honoree
      t.string :payment_channel
      t.string :category
      
      t.boolean :paid, default: false
      
      t.references :backable, polymorphic: true, index: true      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end