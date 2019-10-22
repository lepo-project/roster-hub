class AddMetadataToRclasses < ActiveRecord::Migration[5.1]
  def change
    add_column :rclasses, :metadata, :json, after: :application_id
  end
end
