class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.string :name
      t.string :type
      t.string :identifier
      t.string :parentSourcedId

      t.timestamps
    end
  end
end
