class AddMetadataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :metadata, :text, after: :application_id
  end
end
