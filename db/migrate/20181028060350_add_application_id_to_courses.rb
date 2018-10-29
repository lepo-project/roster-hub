class AddApplicationIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :application_id, :integer, default: 0
    add_index :courses, :application_id
  end
end
