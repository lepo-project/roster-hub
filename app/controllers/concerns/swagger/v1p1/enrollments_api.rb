module Swagger::V1p1::EnrollmentsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/enrollments' do
      operation :get do
        key :summary, 'Return all enrollments.'
        key :description, 'Return collection of all enrollments.'
        key :tags, [
          'enrollment'
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
            property :enrollments do
              key :type, :array
              items do
                key :'$ref', :Enrollment
              end
            end
          end
        end
      end
      operation :post do
        key :summary, 'Create a new enrollment.'
        key :description, 'Create a new enrollment.'
        key :tags, [
          'enrollment'
        ]
        parameter do
          key :name, :enrollment
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :enrollment do
              key :'$ref', :EnrollmentInput
            end
          end
        end
        response 201 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :enrollment do
              key :'$ref', :Enrollment
            end
          end
        end
      end
    end

    swagger_path '/enrollments/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific enrollment.'
        key :description, 'Return specific enrollment.'
        key :tags, [
          'enrollment'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :enrollment do
              key :'$ref', :Enrollment
            end
          end
        end
      end
      operation :put do
        key :summary, 'Replace specific enrollment.'
        key :description, 'Replace specific enrollment.'
        key :tags, [
          'enrollment'
        ]
        parameter :sourcedId
        parameter do
          key :name, :enrollment
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :enrollment do
              key :'$ref', :EnrollmentInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :enrollment do
              key :'$ref', :Enrollment
            end
          end
        end
      end
      operation :delete do
        key :summary, 'Delete specific enrollment.'
        key :description, 'Delete specific enrollment.'
        key :tags, [
          'enrollment'
        ]
        parameter :sourcedId
        response 204 do
          key :description, 'successful operation'
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/enrollments' do
      operation :get do
        key :summary, 'Return all enrollments for this school.'
        key :description, 'Return the collection of all enrollments for this school.'
        key :tags, [
          'enrollment'
        ]
        parameter :schoolSourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :enrollments do
              key :type, :array
              items do
                key :'$ref', :Enrollment
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/classes/{classSourcedId}/enrollments' do
      operation :get do
        key :summary, 'Return all enrollments into this class.'
        key :description, 'Return the collection of all enrollments into this class.'
        key :tags, [
          'enrollment'
        ]
        parameter :schoolSourcedId
        parameter :classSourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :enrollments do
              key :type, :array
              items do
                key :'$ref', :Enrollment
              end
            end
          end
        end
      end
    end
  end
end
