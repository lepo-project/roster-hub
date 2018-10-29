class AddApplicationIdToAcademicSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :academic_sessions, :application_id, :integer, default: 0
    add_index :academic_sessions, :application_id
  end
end
