class CreateRclasses < ActiveRecord::Migration[5.1]
  def change
    create_table :rclasses do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :title
      t.string :courseSourcedId
      t.string :classCode
      t.string :classType
      t.string :schoolSourcedId
      t.string :termSourcedIds
      t.string :periods

      t.timestamps
    end
  end
end
