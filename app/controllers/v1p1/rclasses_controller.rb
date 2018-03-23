module V1p1
  class RclassesController < V1p1::ApplicationController
    include Swagger::V1p1::ClassesApi
    def index
      indexbase(Rclass)
    end
  end
end
