class CreateRclasses < ActiveRecord::Migration[5.1]
  def change
    create_table :rclasses, id: false do |t|
      t.string :sourcedId, primary_key: true, null: false
      t.string :status
      t.datetime :dateLastModified
      t.string :title
      t.string :grades
      t.string :courseSourcedId
      t.string :classCode
      t.string :classType
      t.string :location
      t.string :schoolSourcedId
      t.string :termSourcedIds
      t.string :subjects
      t.string :subjectCodes
      t.string :periods
      t.integer :application_id, default: 0, null: false

      t.timestamps
    end
    # add_index :rclasses, :sourcedId, unique: true
    add_index :rclasses, :courseSourcedId
    add_index :rclasses, :schoolSourcedId
    add_index :rclasses, :termSourcedIds
    add_index :rclasses, :application_id
  end
end
