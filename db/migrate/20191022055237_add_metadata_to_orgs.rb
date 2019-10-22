class AddMetadataToOrgs < ActiveRecord::Migration[5.1]
  def change
    add_column :orgs, :metadata, :json, after: :application_id
  end
end
