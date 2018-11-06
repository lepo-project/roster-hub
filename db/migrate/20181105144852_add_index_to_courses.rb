class AddIndexToCourses < ActiveRecord::Migration[5.1]
  def change
    add_index :courses, :orgSourcedId
  end
end
