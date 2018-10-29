class CreateAcademicSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :academic_sessions do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :title
      t.string :type
      t.date :startDate
      t.date :endDate
      t.string :parentSourcedId
      t.integer :schoolYear
      t.integer :application_id, default: 0, null: false

      t.timestamps
    end
    add_index :academic_sessions, :sourcedId, unique: true
    add_index :academic_sessions, :application_id
  end
end
