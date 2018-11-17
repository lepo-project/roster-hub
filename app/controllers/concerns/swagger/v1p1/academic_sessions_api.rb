module Swagger::V1p1::AcademicSessionsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/academicSessions' do
      operation :get do
        key :summary, 'Return all academic sessions.'
        key :description, 'Return collection of all academic sessions.'
        key :tags, [
          'academicSession'
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
            property :academicSessions do
              key :type, :array
              items do
                key :'$ref', :AcademicSession
              end
            end
          end
        end
      end
      operation :post do
        key :summary, 'Create a new academic session.'
        key :description, 'Create a new academic session.'
        key :tags, [
          'academicSession'
        ]
        parameter do
          key :name, :academicSession
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSessionInput
            end
          end
        end
        response 201 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSession
            end
          end
        end
      end
    end

    swagger_path '/academicSessions/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific academic session.'
        key :description, 'Return specific academic session.'
        key :tags, [
          'academicSession'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSession
            end
          end
        end
      end
      operation :put do
        key :summary, 'Replace specific academic session.'
        key :description, 'Replace specific academic session.'
        key :tags, [
          'academicSession'
        ]
        parameter :sourcedId
        parameter do
          key :name, :academicSession
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSessionInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSession
            end
          end
        end
      end
      operation :delete do
        key :summary, 'Delete specific academic session.'
        key :description, 'Delete specific academic session.'
        key :tags, [
          'academicSession'
        ]
        parameter :sourcedId
        response 204 do
          key :description, 'successful operation'
        end
      end
    end

    swagger_path '/terms' do
      operation :get do
        key :summary, 'Return all terms.'
        key :description, 'Return collection of terms. A Term is an instance of an AcademicSession.'
        key :tags, [
          'academicSession'
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
            property :academicSessions do
              key :type, :array
              items do
                key :'$ref', :AcademicSession
              end
            end
          end
        end
      end
    end

    swagger_path '/terms/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific term.'
        key :description, 'Return specific term.'
        key :tags, [
          'academicSession'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :academicSession do
              key :'$ref', :AcademicSession
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/terms' do
      operation :get do
        key :summary, 'Return all terms that are used by this school.'
        key :description, 'Return the collection of terms that are used by this school.'
        key :tags, [
          'academicSession'
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
            property :academicSessions do
              key :type, :array
              items do
                key :'$ref', :AcademicSession
              end
            end
          end
        end
      end
    end
  end
end
