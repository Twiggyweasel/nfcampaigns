class AddTimestampsToSponsorships < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsorships, :created_at, :datetime
    add_column :sponsorships, :updated_at, :datetime
  end
end
