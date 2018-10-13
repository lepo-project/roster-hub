module Swagger::V1p1::CourseSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Course do
      key :required, [:sourcedId, :title, :courseCode, :orgSourcedId]
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
      property :schoolYearSourcedId do
        key :description, 'not used'
      end
      property :title do
        key :description, 'Course Title'
        key :type, :string
      end
      property :courseCode do
        key :description, 'Course Code'
        key :type, :string
      end
      property :grades do
        key :description, 'not used'
      end
      property :orgSourcedId do
        key :description, 'Link to org. Org sourcedId'
        key :type, :string
      end
      property :subjects do
        key :description, 'not used'
      end
      property :subjectCodes do
        key :description, 'not used'
      end
    end
  end
end
