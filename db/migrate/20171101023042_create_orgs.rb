class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs do |t|
      t.string :sourcedId
      t.string :status
      t.text :metadata
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
