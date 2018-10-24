class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :sourcedId
      t.string :status
      t.datetime :dateLastModified
      t.boolean :enabledUser
      t.string :orgSourcedIds
      t.string :role
      t.string :username
      t.string :userIds
      t.string :givenName
      t.string :familyName
      t.string :middleName
      t.string :identifier
      t.string :email
      t.string :sms
      t.string :phone
      t.string :agentSourcedIds
      t.string :grades
      t.string :password

      t.timestamps
    end
    add_index :users, :sourcedId, unique: true
  end
end
