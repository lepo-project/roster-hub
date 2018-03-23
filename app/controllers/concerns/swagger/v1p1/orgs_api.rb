module Swagger::V1p1::OrgsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/orgs' do
      operation :get do
        key :description, 'Return collection of Orgs.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of Orgs'
          schema type: :array do
            key :'$ref', :Org
          end
        end
      end
    end

    swagger_path '/orgs/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Org by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific org'
          schema do
            key :'$ref', :Org
          end
        end
      end
    end

    swagger_path '/schools' do
      operation :get do
        key :description, 'Return collection of schools. A School is an instance of an Org.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :limit
        parameter :offset
        parameter :sorting
        parameter :orderBy
        parameter :filter

        response 200 do
          key :description, 'Return collection of Schools'
          schema type: :array do
            key :'$ref', :Org
          end
        end
      end
    end

    swagger_path '/schools/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific school by sourcedId. A School is an instance of an Org.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific school'
          schema do
            key :'$ref', :Org
          end
        end
      end
    end
  end
end
