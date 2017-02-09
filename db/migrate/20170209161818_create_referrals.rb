class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.string :referral_code
      t.string :email
      
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.timestamps
    end
  end
end
