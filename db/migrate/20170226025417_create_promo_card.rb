class CreatePromoCard < ActiveRecord::Migration[5.0]
  def change
    create_table :promo_cards do |t|
      t.string :image
      t.string :background_image
      t.string :align_image
      t.integer :text
      t.references :event, foreign_key: true
      t.references :promotion, foreign_key: true
      
      t.timestamps
    end
  end
end
