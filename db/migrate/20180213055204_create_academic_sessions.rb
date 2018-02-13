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
      t.integer :schoolYear

      t.timestamps
    end
  end
end
