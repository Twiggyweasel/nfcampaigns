class CreatePledgePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pledge_pages do |t|
      t.string :nf_connection
      t.text :custom_story
      
      t.float :goal
      t.string :pledge_pic
      t.boolean :has_custom
      t.boolean :has_customized
      t.references :attendee, foreign_key: true
    end
  end
end
