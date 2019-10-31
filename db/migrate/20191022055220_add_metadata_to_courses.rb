class AddMetadataToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :metadata, :text, after: :application_id
  end
end
