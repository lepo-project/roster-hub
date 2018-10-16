module Swagger::V1p1::UserSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :User do
      key :required, [:sourcedId, :enabledUser, :orgSourcedIds, :role, :username, :givenName, :familyName, :email]
      property :sourcedId do
        key :description, 'Source Identifier'
        key :type, :string
      end
      property :status do
        key :description, 'not used'
      end
      property :dateLastModified do
        key :description, 'not used'
      end
      property :enabledUser do
        key :description, 'Fixed value, true'
        key :type, :boolean
      end
      property :orgSourcedIds do
        key :description, 'Links to orgs. Org sourcedId'
        key :type, :string
      end
      property :role do
        key :description, 'Role type'
        key :type, :string
        key :enum, ['administrator', 'aide', 'guardian', 'parent', 'proctor', 'relative', 'student', 'teacher']
      end
      property :username do
        key :description, 'User ID'
        key :type, :string
      end
      property :userIds do
        key :description, 'not used'
      end
      property :givenName do
        key :description, 'Given Name. For example: Hanako'
        key :type, :string
      end
      property :familyName do
        key :description, 'Family Name. For example: Takahashi'
        key :type, :string
      end
      property :middleName do
        key :description, 'not used'
      end
      property :identifier do
        key :description, 'not used'
      end
      property :email do
        key :description, 'Mail Address'
        key :type, :string
      end
      property :sms do
        key :description, 'not used'
      end
      property :phone do
        key :description, 'not used'
      end
      property :agentSourcedIds do
        key :description, 'not used'
      end
      property :grades do
        key :description, 'not used'
      end
      property :password do
        key :description, 'not used'
      end
    end
  end
end
