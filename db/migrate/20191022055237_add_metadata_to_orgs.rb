class AddMetadataToOrgs < ActiveRecord::Migration[5.1]
  def change
    add_column :orgs, :metadata, :text, after: :application_id
  end
end
