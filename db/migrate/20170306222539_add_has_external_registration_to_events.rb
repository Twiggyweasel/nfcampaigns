class AddHasExternalRegistrationToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :has_external_registration, :boolean, default: false
    add_column :events, :external_url, :string
  end
end
