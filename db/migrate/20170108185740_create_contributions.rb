class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.string :honoree
      t.string :processing
      
      t.references :backable, polymorphic: true, index: true      
      t.timestamps
    end
  end
end