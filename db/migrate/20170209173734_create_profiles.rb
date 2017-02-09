class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :street
      t.string :apt
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :referral_code
      t.boolean :has_nf
      t.boolean :child_with_nf
      t.boolean :system_notifications
      t.boolean :event_notifications
      t.boolean :is_private


      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
