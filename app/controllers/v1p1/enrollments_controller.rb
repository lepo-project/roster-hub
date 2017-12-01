module V1p1
  class EnrollmentsController < V1p1::ApplicationController
    def index
      indexbase(Enrollment)
    end
  end
end
