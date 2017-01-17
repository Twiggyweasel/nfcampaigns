class CreatePledgePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pledge_pages do |t|
      t.text :summary
      t.float :goal
      t.string :pledge_pic
      t.references :attendee, foreign_key: true
    end
  end
end
