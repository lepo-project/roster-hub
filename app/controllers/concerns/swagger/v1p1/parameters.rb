module Swagger::V1p1::Parameters
  def self.extended(base)
   
    base.parameter :limit do
      key :name, :limit
      key :in, :query
      key :description, 'The number of results to return. The default value is 100.'
      key :type, :integer
      key :required, false
    end
    
    base.parameter :offset do
      key :name, :offset
      key :in, :query
      key :description, 'The index of the first record to return. The default value is 0. (zero indexed)'
      key :type, :integer
      key :required, false
    end
    
    base.parameter :sorting do
      key :name, :sort
      key :in, :query
      key :description, "Sort by data_field. Use 'orderBy' to sort the result in ascending or descending order."
      key :type, :string
      key :required, false
    end
    
    base.parameter :orderBy do
      key :name, :orderBy
      key :in, :query
      key :description, 'This by be used in the request to ask for the collection to be ordered ascending(asc) or descending(desc).'
      key :type, :string
      key :enum, ['asc', 'desc']
      key :required, false
    end
    
    base.parameter :filter do
      key :name, :filter
      key :in, :query
      key :description, "Filter requests must consist of the form: <data field><predicate><value> or <data field><predicate><value><logical><data field><predicate><value>. Filter queries must be URL encoded."
      key :type, :string
      key :required, false
    end
    
    base.parameter :sourcedId do
      key :name, :sourcedId
      key :in, :path
      key :description, 'ID of org'
      key :required, true
      key :type, :string
    end
  end
end