module V1p1
  class AcademicSessionsController < V1p1::ApplicationController
    include Swagger::V1p1::AcademicSessionsApi

    def school
      termSourcedIds = Rclass.where(schoolSourcedId: params[:schoolSourcedId]).pluck(:termSourcedIds).uniq
      # Assumption: Class does not belong to multiple terms
      relations = AcademicSession.where(sourcedId: termSourcedIds)
      relations = indexbase_with_condition(relations)
      render_json('AcademicSession', relations)
    end

    def term
      relations = AcademicSession.where(type: 'term')
      relations = indexbase_with_condition(relations)
      render_json('AcademicSession', relations)
    end

    private

    def strong_params
      params.require(:academicSession).permit(:status, :dateLastModified, :title, :type, :startDate, :endDate, :parentSourcedId, :schoolYear)
    end
  end
end
