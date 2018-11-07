class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments, id: false do |t|
      t.string :sourcedId, primary_key: true, null: false
      t.string :status
      t.datetime :dateLastModified
      t.string :classSourcedId
      t.string :schoolSourcedId
      t.string :userSourcedId
      t.string :role
      t.boolean :primary
      t.date :beginDate
      t.date :endDate
      t.integer :application_id, default: 0, null: false

      t.timestamps
    end
    # add_index :enrollments, :sourcedId, unique: true
    add_index :enrollments, :classSourcedId
    add_index :enrollments, :schoolSourcedId
    add_index :enrollments, :userSourcedId
    add_index :enrollments, :application_id
  end
end
