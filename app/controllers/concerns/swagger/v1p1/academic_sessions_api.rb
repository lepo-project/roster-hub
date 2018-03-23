module Swagger::V1p1::AcademicSessionsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/academicSessions' do
      operation :get do
        key :description, 'Return collection of all academic sessions.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of all academic sessions'
          schema type: :array do
            key :'$ref', :AcademicSession
          end
        end
      end
    end

    swagger_path '/academicSessions/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Academic Session by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Academic Session'
          schema do
            key :'$ref', :AcademicSession
          end
        end
      end
    end
  end
end
