module Swagger::V1p1::ClassesApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/classes' do
      operation :get do
        key :description, 'Return collection of classes.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
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
    end

    swagger_path '/classes/{sourcedId}' do
      operation :get do
        key :description, 'Return Specific Class by sourcedId.'
        key :operation, :indexbase_with_condition

        parameter :accesstoken
        parameter :sourcedId

        response 200 do
          key :description, 'Return Specific Class'
          schema do
            key :'$ref', :Rclass
          end
        end
      end
    end
  end
end
