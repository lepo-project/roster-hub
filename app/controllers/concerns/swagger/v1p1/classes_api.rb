module Swagger::V1p1::ClassesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/classes' do
      operation :get do
        key :summary, 'Return all classes.'
        key :description, 'Return collection of classes.'
        key :tags, [
          'class'
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
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
      operation :post do
        key :summary, 'Create a new class.'
        key :description, 'Create a new class.'
        key :tags, [
          'class'
        ]
        parameter do
          key :name, :class
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :class do
              key :'$ref', :RclassInput
            end
          end
        end
        response 200 do
          key :description, 'Create a new class'
          schema do
            key :type, :object
            property :class do
              key :'$ref', :Rclass
            end
          end
        end
      end
    end

    swagger_path '/classes/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific class.'
        key :description, 'Return specific class.'
        key :tags, [
          'class'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :class do
              key :'$ref', :Rclass
            end
          end
        end
      end
      operation :put do
        key :summary, 'Replace specific class.'
        key :description, 'Replace specific class.'
        key :tags, [
          'class'
        ]
        parameter :sourcedId
        parameter do
          key :name, :class
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :class do
              key :'$ref', :RclassInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :class do
              key :'$ref', :Rclass
            end
          end
        end
      end
      operation :delete do
        key :summary, 'Delete specific class.'
        key :description, 'Delete specific class.'
        key :tags, [
          'class'
        ]
        parameter :sourcedId
        response 204 do
          key :description, 'successful operation'
        end
      end
    end

    swagger_path '/terms/{termSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes that are taught in this term.'
        key :description, 'Return the collection of classes that are taught in this term.'
        key :tags, [
          'class'
        ]
        parameter :termSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end

    swagger_path '/courses/{courseSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes that are teaching this course.'
        key :description, 'Return the collection of classes that are teaching this course.'
        key :tags, [
          'class'
        ]
        parameter :courseSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end

    swagger_path '/students/{userSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes that this student is taking.'
        key :description, 'Return the collection of classes that this student is taking.'
        key :tags, [
          'class'
        ]
        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end

    swagger_path '/teachers/{userSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes that this teacher is teaching.'
        key :description, 'Return the collection of classes that this teacher is teaching.'
        key :tags, [
          'class'
        ]
        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes taught by this school.'
        key :description, 'Return the collection of classes taught by this school.'
        key :tags, [
          'class'
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
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end

    swagger_path '/users/{userSourcedId}/classes' do
      operation :get do
        key :summary, 'Return all classes attended by this user.'
        key :description, 'Return the collection of classes attended by this user.'
        key :tags, [
          'class'
        ]
        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :classes do
              key :type, :array
              items do
                key :'$ref', :Rclass
              end
            end
          end
        end
      end
    end
  end
end
