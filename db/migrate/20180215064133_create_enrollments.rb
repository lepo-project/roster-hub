class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :classSourcedId
      t.string :schoolSourcedId
      t.string :userSourcedId
      t.string :role
      t.boolean :primary
      t.date :beginDate
      t.date :endDate

      t.timestamps
    end
  end
end
