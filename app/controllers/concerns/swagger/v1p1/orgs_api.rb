module Swagger::V1p1::OrgsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/orgs' do
      operation :get do
        key :summary, 'Return all orgs.'
        key :description, 'Return collection of orgs.'
        key :tags, [
          'org'
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
            property :orgs do
              key :type, :array
              items do
                key :'$ref', :Org
              end
            end
          end
        end
      end
      operation :post do
        key :summary, 'Create a new org.'
        key :description, 'Create a new org.'
        key :tags, [
          'org'
        ]
        parameter do
          key :name, :org
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :org do
              key :'$ref', :OrgInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :org do
              key :'$ref', :Org
            end
          end
        end
      end
    end

    swagger_path '/orgs/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific org.'
        key :description, 'Return specific org.'
        key :tags, [
          'org'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :org do
              key :'$ref', :Org
            end
          end
        end
      end
      operation :put do
        key :summary, 'Replace specific org.'
        key :description, 'Replace specific org.'
        key :tags, [
          'org'
        ]
        parameter :sourcedId
        parameter do
          key :name, :org
          key :in, :body
          key :required, true
          schema do
            key :type, :object
            property :org do
              key :'$ref', :OrgInput
            end
          end
        end
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :org do
              key :'$ref', :Org
            end
          end
        end
      end
      operation :delete do
        key :summary, 'Delete specific org.'
        key :description, 'Delete specific org.'
        key :tags, [
          'org'
        ]
        parameter :sourcedId
        response 204 do
          key :description, 'successful operation'
        end
      end
    end

    swagger_path '/schools' do
      operation :get do
        key :summary, 'Return all schools.'
        key :description, 'Return collection of schools. A School is an instance of an Org.'
        key :tags, [
          'org'
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
            property :orgs do
              key :type, :array
              items do
                key :'$ref', :Org
              end
            end
          end
        end
      end
    end

    swagger_path '/schools/{sourcedId}' do
      operation :get do
        key :summary, 'Return specific school.'
        key :description, 'Return specific school. A school is an instance of an org.'
        key :tags, [
          'org'
        ]
        parameter :sourcedId
        response 200 do
          key :description, 'successful operation'
          schema do
            key :type, :object
            property :org do
              key :'$ref', :Org
            end
          end
        end
      end
    end
  end
end
