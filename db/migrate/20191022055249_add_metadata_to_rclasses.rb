class AddMetadataToRclasses < ActiveRecord::Migration[5.1]
  def change
    add_column :rclasses, :metadata, :text, after: :application_id
  end
end
