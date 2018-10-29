class AddApplicationIdToEnrollments < ActiveRecord::Migration[5.1]
  def change
    add_column :enrollments, :application_id, :integer, default: 0
    add_index :enrollments, :application_id
  end
end
