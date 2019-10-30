module Swagger::V1p1::OrgSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Org do
      key :required, %i[sourcedId name type]
      property :sourcedId do
        key :description, 'Source Identifier'
        key :type, :string
      end
      property :status do
        key :description, 'not used'
      end
      property :dateLastModified do
        key :description, 'not used'
      end
      property :name do
        key :description, 'Organization name'
        key :type, :string
      end
      property :type do
        key :description, 'Organization type'
        key :type, :string
        key :enum, %w[departmnet school distinct local state national]
      end
      property :identifier do
        key :description, 'not used'
      end
      property :parentSourcedId do
        key :description, 'not used'
      end
      if METADATA[:orgs]
        property :metadata do
          key :type, :object
          METADATA[:orgs].each do |k, v|
            property k do
              key :description, v[:description] if v[:description]
              key :type, v[:type] if v[:type]
            end
          end
        end
      end
    end

    swagger_schema :OrgInput do
      property :status do
        key :description, 'not used'
      end
      property :dateLastModified do
        key :description, 'not used'
      end
      property :name do
        key :description, 'Organization name'
        key :type, :string
      end
      property :type do
        key :description, 'Organization type'
        key :type, :string
        key :enum, %w[departmnet school distinct local state national]
      end
      property :identifier do
        key :description, 'not used'
      end
      property :parentSourcedId do
        key :description, 'not used'
      end
      if METADATA[:orgs]
        property :metadata do
          key :type, :object
          METADATA[:orgs].each do |k, v|
            property k do
              key :description, v[:description] if v[:description]
              key :type, v[:type] if v[:type]
            end
          end
        end
      end
    end
  end
end
