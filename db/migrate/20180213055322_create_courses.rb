class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :title
      t.string :courseCode
      t.string :orgSourcedId

      t.timestamps
    end
  end
end
