module Swagger::V1p1::ClassSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Rclass do
      key :required, [:sourcedId, :title, :courseSourcedId, :classCode, :classType, :schoolSourcedId, :termSourcedIds, :periods]
      property :status do
        key :description, 'not used'
      end
      property :dateLastModified do
        key :description, 'not used'
      end
      property :title do
        key :description, 'Class Title'
        key :type, :string
      end
      property :grades do
        key :description, 'not used'
      end
      property :courseSourcedId do
        key :description, 'Link to course. Course sourcedId'
        key :type, :string
      end
      property :classCode do
        key :description, 'Class code. Timetable Code.'
        key :type, :string
      end
      property :classType do
        key :description, "Class type."
        key :type, :string
        key :enum, ['homeroom', 'scheduled']
      end
      property :location do
        key :description, 'not used'
      end
      property :schoolSourcedId do
        key :description, 'Link to school(org). Org sourcedId'
        key :type, :string
      end
      property :termSourcedIds do
        key :description, 'Link to terms or semesters. AcademicSession sourcedId'
        key :type, :string
      end
      property :subject do
        key :description, 'not used'
      end
      property :subjectCodes do
        key :description, 'not used'
      end
      property :periods do
        key :description, 'The time slots in the day that the class will be given.'
        key :type, :string
      end
    end
  end
end
