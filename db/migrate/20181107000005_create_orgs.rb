class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs, id: false do |t|
      t.string :sourcedId, primary_key: true, null: false
      t.string :status
      t.datetime :dateLastModified
      t.string :name
      t.string :type
      t.string :identifier
      t.string :parentSourcedId
      t.integer :application_id, default: 0, null: false

      t.timestamps
    end
    # add_index :orgs, :sourcedId, unique: true
    add_index :orgs, :application_id
  end
end
