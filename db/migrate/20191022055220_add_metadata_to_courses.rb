class AddMetadataToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :metadata, :json, after: :application_id
  end
end
