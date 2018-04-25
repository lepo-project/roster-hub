module Swagger::V1p1::UsersApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/users' do
      operation :get do
        key :description, 'Return collection of users.'
        key :operation, :indexbase_with_condition

        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of users'
          schema type: :array do
            key :'$ref', :User
          end
        end
      end
    end

    swagger_path '/users/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific User by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific User'
          schema do
            key :'$ref', :User
          end
        end
      end
    end

    swagger_path '/students' do
      operation :get do
        key :description, 'Return collection of students. A Student is an instance of a User.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of students'
          schema type: :array do
            key :'$ref', :User
          end
        end
      end
    end

    swagger_path '/students/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific student by sourcedId. A Student is an instance of an User.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific student'
          schema do
            key :'$ref', :User
          end
        end
      end
    end

    swagger_path '/teachers' do
      operation :get do
        key :description, 'Return collection of teachers. A Teacher is an instance of a User.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of teachers'
          schema type: :array do
            key :'$ref', :User
          end
        end
      end
    end

    swagger_path '/teachers/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific teacher by sourcedId. A Teacher is an instance of an User.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific teacher'
          schema do
            key :'$ref', :User
          end
        end
      end
    end
  end
end
