class AddMetadataToEnrollments < ActiveRecord::Migration[5.1]
  def change
    add_column :enrollments, :metadata, :json, after: :application_id
  end
end
