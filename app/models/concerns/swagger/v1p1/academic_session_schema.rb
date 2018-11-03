module Swagger::V1p1::AcademicSessionSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :AcademicSession do
    key :required, [:sourcedId, :title, :type, :startDate, :endDate, :schoolYear]
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
      property :title do
        key :description, "'YYYY-TERM' TERM: first/second/full/intensive"
        key :type, :string
      end
      property :type do
        key :description, "Fixed value, 'term'"
        key :type, :string
      end
      property :startDate do
        key :description, "'YYYY-MM-DD' first/full/intensive:YYYY-04-01, second:YYYY-10-01"
        key :type, :string
        key :format, 'YYYY-mm-dd'
      end
      property :endDate do
        key :description, "'YYYY-MM-DD' first:YYYY-10-01, second/full/intensive:YYYY-04-01"
        key :type, :string
        key :format, 'YYYY-mm-dd'
      end
      property :parentSourcedId do
        key :description, 'not used'
      end
      property :schoolYear do
        key :description, "'YYYY' The school year for the academic session. This year should include the school year end."
        key :type, :string
        key :format, 'YYYY'
      end
    end

    swagger_schema :AcademicSessionInput do
      property :status do
        key :description, 'not used'
      end
      property :dateLastModified do
        key :description, 'not used'
      end
      property :title do
        key :description, "'YYYY-TERM' TERM: first/second/full/intensive"
        key :type, :string
      end
      property :type do
        key :description, "Fixed value, 'term'"
        key :type, :string
      end
      property :startDate do
        key :description, "'YYYY-MM-DD' first/full/intensive:YYYY-04-01, second:YYYY-10-01"
        key :type, :string
        key :format, 'YYYY-mm-dd'
      end
      property :endDate do
        key :description, "'YYYY-MM-DD' first:YYYY-10-01, second/full/intensive:YYYY-04-01"
        key :type, :string
        key :format, 'YYYY-mm-dd'
      end
      property :parentSourcedId do
        key :description, 'not used'
      end
      property :schoolYear do
        key :description, "'YYYY' The school year for the academic session. This year should include the school year end."
        key :type, :string
        key :format, 'YYYY'
      end
    end

  end
end
