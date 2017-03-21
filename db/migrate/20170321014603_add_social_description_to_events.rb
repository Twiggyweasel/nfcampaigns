class AddSocialDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :social_desc, :text
  end
end
