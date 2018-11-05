module Swagger::V1p1::CoursesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/courses' do
      operation :get do
        key :summary, 'Return all courses.'
        key :description, 'Return collection of courses.'
        key :tags, [
          'course'
        ]
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :courses do
              key :type, :array
              items do
                key :'$ref', :Course
              end
            end
          end
        end
      end
      operation :post do
        key :summary, 'Create a new course.'
        key :description, 'Create a new course.'
        key :tags, [
          'course'
        ]
        parameter do
          key :name, :course
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :course do
              key :'$ref', :CourseInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :course do
              key :'$ref', :Course
            end
          end
        end
      end
    end

    swagger_path '/courses/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific course.'
        key :description, 'Return specific course.'
        key :tags, [
          'course'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :course do
              key :'$ref', :Course
            end
          end
        end
      end
      operation :put do
        key :summary, 'Replace specific course.'
        key :description, 'Replace specific course.'
        key :tags, [
          'course'
        ]
        parameter :sourcedId
        parameter do
          key :name, :course
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :course do
              key :'$ref', :CourseInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :course do
              key :'$ref', :Course
            end
          end
        end
      end
      operation :delete do
        key :summary, 'Delete specific course.'
        key :description, 'Delete specific course.'
        key :tags, [
          'course'
        ]
        parameter :sourcedId
        response 204 do
          key :description, 'successful operation'
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/courses' do
      operation :get do
        key :summary, 'Return all courses taught by this school.'
        key :description, 'Return the collection of courses taught by this school.'
        key :tags, [
          'course'
        ]
        parameter :schoolSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :courses do
              key :type, :array
              items do
                key :'$ref', :Course
              end
            end
          end
        end
      end
    end
  end
end
