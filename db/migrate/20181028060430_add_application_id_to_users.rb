class AddApplicationIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :application_id, :integer, default: 0
    add_index :users, :application_id
  end
end
