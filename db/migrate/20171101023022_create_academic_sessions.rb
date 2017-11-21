class CreateAcademicSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :academic_sessions do |t|
      t.string :sourcedId
      t.string :status
      t.text :metadata
      t.string :title
      t.date :startDate
      t.date :endDate
      t.string :type
      t.integer :schoolYear

      t.timestamps
    end
  end
end
