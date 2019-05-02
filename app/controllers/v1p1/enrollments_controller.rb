module V1p1
  class EnrollmentsController < V1p1::ApplicationController
    include Swagger::V1p1::EnrollmentsApi

    def school
      relations = Enrollment.where(schoolSourcedId: params[:schoolSourcedId])
      relations = indexbase_with_condition(relations)
      render_json('Enrollment', relations)
    end

    def class_in_school
      relations = Enrollment.where(schoolSourcedId: params[:schoolSourcedId], classSourcedId: params[:classSourcedId])
      relations = indexbase_with_condition(relations)
      render_json('Enrollment', relations)
    end

    private

    def strong_params
      params.require(:enrollment).permit(:status, :dateLastModified, :classSourcedId, :schoolSourcedId, :userSourcedId, :role, :primary, :beginDate, :endDate)
    end
  end
end
