module V1p1
  class EnrollmentsController < V1p1::ApplicationController
    include Swagger::V1p1::EnrollmentsApi

    private

    def strong_params
      params.require(:enrollment).permit(:status, :dateLastModified, :classSourcedId, :schoolSourcedId, :userSourcedId, :role, :primary, :beginDate, :endDate)
    end
  end
end
