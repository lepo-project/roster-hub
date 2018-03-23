module Swagger::V1p1::EnrollmentSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Enrollment do
      key :required, [:sourcedId, :classSourcedId, :schoolSourcedId, :userSourcedId, :role, :primary]
      property :id do
        key :description, 'Internal identifier'
        key :type, :integer
      end
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
      property :classSourcedId do
        key :description, 'Link to the class. Class sourcedId'
        key :type, :string
      end
      property :schoolSourcedId do
        key :description, 'Link to the school. Org sourcedId'
        key :type, :string
      end
      property :userSourcedId do
        key :description, 'Link to the enrolled user. User sourcedId'
        key :type, :string
      end
      property :role do
        key :description, 'Enrollment role'
        key :type, :string
        key :enum, ['administrator', 'aide', 'guardian', 'parent', 'proctor', 'relative', 'student', 'teacher']
      end
      property :primary do
        key :description, 'Applicable only to teachers. Only one teacher should be designated as the primary teacher for a class in the period defined by the begin/end dates.'
        key :type, :boolean
      end
      property :beginDate do
        key :description, 'not used'
      end
      property :endDate do
        key :description, 'not used'
      end
      property :created_at do
        key :description, 'System internal value'
        key :type, :string
      end
      property :updated_at do
        key :description, 'System internal value'
        key :type, :string
      end
    end
  end
end
