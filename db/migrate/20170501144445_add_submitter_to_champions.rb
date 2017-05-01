class AddSubmitterToChampions < ActiveRecord::Migration[5.0]
  def change
    add_column :champions, :submitter, :string
  end
end
