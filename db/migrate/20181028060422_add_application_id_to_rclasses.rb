class AddApplicationIdToRclasses < ActiveRecord::Migration[5.1]
  def change
    add_column :rclasses, :application_id, :integer, default: 0
    add_index :rclasses, :application_id
  end
end
