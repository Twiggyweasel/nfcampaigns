class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :desc
      t.string :code
      t.float :discount
      t.boolean :is_active, default: false
      
      t.timestamps
    end
  end
end
