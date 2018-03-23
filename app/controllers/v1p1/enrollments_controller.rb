module V1p1
  class EnrollmentsController < V1p1::ApplicationController
    include Swagger::V1p1::EnrollmentsApi
    def index
      indexbase(Enrollment)
    end
  end
end
