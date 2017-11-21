class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :sourcedId
      t.string :status
      t.text :metadata
      t.boolean :enabledUser
      t.string :orgSourcedIds
      t.string :role
      t.string :username
      t.string :givenName
      t.string :familyName
      t.string :email

      t.timestamps
    end
  end
end
