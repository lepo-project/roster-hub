module Swagger::V1p1::EnrollmentsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/enrollments' do
      operation :get do
        key :description, 'Return collection of all enrollments.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of enrollments'
          schema type: :array do
            key :'$ref', :Enrollment
          end
        end
      end
    end

    swagger_path '/enrollments/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Enrollment by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Enrollment'
          schema do
            key :'$ref', :Enrollment
          end
        end
      end
    end
  end
end
