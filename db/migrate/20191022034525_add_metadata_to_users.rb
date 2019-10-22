class AddMetadataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :metadata, :json, after: :application_id
  end
end
