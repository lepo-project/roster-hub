class AddApplicationIdToOrgs < ActiveRecord::Migration[5.1]
  def change
    add_column :orgs, :application_id, :integer, default: 0
    add_index :orgs, :application_id
  end
end
