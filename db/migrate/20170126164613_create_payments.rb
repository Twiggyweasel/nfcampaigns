class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :last4
      t.string :promo_code
      t.integer :confirmation_number
      t.float :amount
      t.boolean :success
      t.boolean :cover_processing
      t.string :authorization_code
      
      t.references :payable, polymorphic:true, index: true
      t.timestamps
    end
  end
end
