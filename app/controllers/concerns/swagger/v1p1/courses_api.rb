module Swagger::V1p1::CoursesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/courses' do
      operation :get do
        key :description, 'Return collection of courses.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of courses'
          schema type: :array do
            key :'$ref', :Course
          end
        end
      end
    end

    swagger_path '/courses/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Course by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Course'
          schema do
            key :'$ref', :Course
          end
        end
      end
    end
  end
end
