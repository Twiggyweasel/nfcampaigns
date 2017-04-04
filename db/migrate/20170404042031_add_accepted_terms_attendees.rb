class AddAcceptedTermsAttendees < ActiveRecord::Migration[5.0]
  def change
    add_column :attendees, :accepted_terms, :boolean, default: false
  end
end
