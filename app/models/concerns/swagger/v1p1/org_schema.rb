module Swagger::V1p1::OrgSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Org do
      key :required, [:sourcedId, :name, :type]
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
      property :name do
        key :description, 'Organization name'
        key :type, :string
      end
      property :type do
        key :description, 'Organization type'
        key :type, :string
        key :enum, ['departmnet', 'school', 'distinct', 'local', 'state', 'national']
      end
      property :identifier do
        key :description, 'not used'
      end
      property :parentSourcedId do
        key :description, 'not used'
      end
    end
  end
end
