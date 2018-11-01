module Swagger::V1p1::EnrollmentsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/enrollments' do
      operation :get do
        key :description, 'Return collection of all enrollments.'
        key :operation, :indexbase_with_condition

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
      operation :post do
        key :description, 'Create a new Enrollment record.'

        response 200 do
          key :description, 'Create a new Enrollment record.'
          schema do
            key :'$ref', :Enrollment
          end
        end
      end
    end

    swagger_path '/enrollments/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Enrollment by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Enrollment'
          schema do
            key :'$ref', :Enrollment
          end
        end
      end
      operation :put do
        key :description, 'Replace a Enrollment that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Replace a Enrollment that already exists.'
          schema do
            key :'$ref', :Enrollment
          end
        end
      end
      operation :delete do
        key :description, 'Delete a Enrollment that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Delete a Enrollment that already exists.'
        end
      end
    end
  end
end
