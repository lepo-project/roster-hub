module Swagger::V1p1::UsersApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/users' do
      operation :get do
        key :summary, 'Return all users.'
        key :description, 'Return collection of users.'
        key :tags, [
          'user'
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
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/users/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific user.'
        key :description, 'Return specific user.'
        key :tags, [
          'user'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :user do
              key :'$ref', :User
            end
          end
        end
      end
    end

    swagger_path '/students' do
      operation :get do
        key :summary, 'Return all students.'
        key :description, 'Return collection of students. A student is an instance of a user.'
        key :tags, [
          'user'
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
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/students/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific student.'
        key :description, 'Return specific student. A student is an instance of an user.'
        key :tags, [
          'user'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :user do
              key :'$ref', :User
            end
          end
        end
      end
    end

    swagger_path '/teachers' do
      operation :get do
        key :summary, 'Return all teachers.'
        key :description, 'Return collection of teachers. A Teacher is an instance of a User.'
        key :tags, [
          'user'
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
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/teachers/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific teacher.'
        key :description, 'Return specific teacher. A teacher is an instance of an user.'
        key :tags, [
          'user'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :user do
              key :'$ref', :User
            end
          end
        end
      end
    end

    swagger_path '/classes/{classSourcedId}/students' do
      operation :get do
        key :summary, 'Return all students that are taking this class.'
        key :description, 'Return the collection of students that are taking this class.'
        key :tags, [
          'user'
        ]
        parameter :classSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/classes/{classSourcedId}/teachers' do
      operation :get do
        key :summary, 'Return all teachers that are teaching this class.'
        key :description, 'Return the collection of teachers that are teaching this class.'
        key :tags, [
          'user'
        ]
        parameter :classSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/students' do
      operation :get do
        key :summary, 'Return all students attending this school.'
        key :description, 'Return the collection of students attending this school.'
        key :tags, [
          'user'
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
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/teachers' do
      operation :get do
        key :summary, 'Return all teachers teaching at this school.'
        key :description, 'Return the collection of teachers teaching at this school.'
        key :tags, [
          'user'
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
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/classes/{classSourcedId}/students' do
      operation :get do
        key :summary, 'Return all students that are taking this class in this school.'
        key :description, 'Return the collection of students taking this class in this school.'
        key :tags, [
          'user'
        ]
        parameter :schoolSourcedId
        parameter :classSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{schoolSourcedId}/classes/{classSourcedId}/teachers' do
      operation :get do
        key :summary, 'Return all teachers that are teaching this class in this school.'
        key :description, 'Return the collection of teachers taking this class in this school.'
        key :tags, [
          'user'
        ]
        parameter :schoolSourcedId
        parameter :classSourcedId
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :users do
              key :type, :array
              items do
                key :'$ref', :User
              end
            end
          end
        end
      end
    end
  end
end
