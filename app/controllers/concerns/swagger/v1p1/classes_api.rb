module Swagger::V1p1::ClassesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/classes' do
      operation :get do
        key :description, 'Return collection of classes.'
        key :operation, :indexbase_with_condition

        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of classes'
          schema type: :array do
            key :'$ref', :Rclass
          end
        end
      end
      operation :post do
        key :description, 'Create a new Class record.'

        response 200 do
          key :description, 'Create a new Class record'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/classes/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Class by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Class'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
      operation :put do
        key :description, 'Replace a Class that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Replace a Class that already exists.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
      operation :delete do
        key :description, 'Delete a Class that already exists.'

        parameter :sourcedId

        response 200 do
          key :description, 'Delete a Class that already exists.'
        end
      end
    end

    swagger_path '/courses/{termSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes that are taught in this term.'
        key :operation, :indexbase_with_condition

        parameter :termSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes that are taught in this term.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/courses/{courseSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes that are teaching this course.'
        key :operation, :indexbase_with_condition

        parameter :courseSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes that are teaching this course.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/students/{userSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes that this student is taking.'
        key :operation, :indexbase_with_condition

        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes that this student is taking.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/teachers/{userSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes that this teacher is teaching.'
        key :operation, :indexbase_with_condition

        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes that this teacher is teaching.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes taught by this school.'
        key :operation, :indexbase_with_condition

        parameter :schoolSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes taught by this school.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end

    swagger_path '/users/{userSourcedId}/classes' do
      operation :get do
        key :description, 'Return the collection of classes attended by this user.'
        key :operation, :indexbase_with_condition

        parameter :userSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return the collection of classes attended by this user.'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end
  end
end
