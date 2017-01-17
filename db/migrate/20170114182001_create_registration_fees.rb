class CreateRegistrationFees < ActiveRecord::Migration[5.0]
  def change
    create_table :registration_fees do |t|
      t.string :name
      t.decimal :amount
      
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
