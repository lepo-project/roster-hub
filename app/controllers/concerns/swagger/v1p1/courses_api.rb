module Swagger::V1p1::CoursesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/courses' do
      operation :get do
        key :description, 'Return collection of courses.'
        key :operation, :indexbase_with_condition

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
      operation :post do
        key :description, 'Create a new Course record.'

        response 200 do
          key :description, 'Create a new Course record'
          schema do
            key :'$ref', :Course
          end
        end
      end
    end

    swagger_path '/courses/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Course by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Course'
          schema do
            key :'$ref', :Course
          end
        end
      end
      operation :put do
        key :description, 'Replace a Course that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Replace a Course that already exists.'
          schema do
            key :'$ref', :Course
          end
        end
      end
      operation :delete do
        key :description, 'Delete a Course that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Delete a Course that already exists.'
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/courses' do
      operation :get do
        key :description, 'Return the collection of courses taught by this school.'
        key :operation, :indexbase_with_condition

        parameter :schoolSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of courses taught by this school.'
          schema do
            key :'$ref', :Course
          end
        end
      end
    end
  end
end
