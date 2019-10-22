class AddMetadataToAcademicSesions < ActiveRecord::Migration[5.1]
  def change
    add_column :academic_sessions, :metadata, :json, after: :application_id
  end
end
