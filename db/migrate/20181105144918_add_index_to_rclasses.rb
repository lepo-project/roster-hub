class AddIndexToRclasses < ActiveRecord::Migration[5.1]
  def change
    add_index :rclasses, :schoolSourcedId
  end
end
