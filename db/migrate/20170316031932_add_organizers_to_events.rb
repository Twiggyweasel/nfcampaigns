class AddOrganizersToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :organizer_url, :string
    add_column :events, :organizer_logo, :string
  end
end
