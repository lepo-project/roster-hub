class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :schoolYearSourcedId
      t.string :title
      t.string :courseCode
      t.string :grades
      t.string :orgSourcedId
      t.string :subjects
      t.string :subjectCodes
      t.integer :application_id, default: 0, null: false

      t.timestamps
    end
    add_index :courses, :sourcedId, unique: true
    add_index :courses, :application_id
  end
end
