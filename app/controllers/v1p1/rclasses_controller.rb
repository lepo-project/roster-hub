module V1p1
  class RclassesController < V1p1::ApplicationController
    include Swagger::V1p1::ClassesApi

    def index
      render_class_json Rclass.all
    end

    def course
      render_class_json Rclass.where(courseSourcedId: params[:courseSourcedId])
    end

    def school
      render_class_json Rclass.where(schoolSourcedId: params[:schoolSourcedId])
    end

    def student
      sourcedIds = Enrollment.where(userSourcedId: params[:userSourcedId], role: 'student').pluck(:classSourcedId)
      render_class_json Rclass.where(sourcedId: sourcedIds)
    end

    def teacher
      sourcedIds = Enrollment.where(userSourcedId: params[:userSourcedId], role: 'teacher').pluck(:classSourcedId)
      render_class_json Rclass.where(sourcedId: sourcedIds)
    end

    def term
      render_class_json Rclass.where(termSourcedIds: params[:termSourcedId])
    end

    def user
      sourcedIds = Enrollment.where(userSourcedId: params[:userSourcedId]).pluck(:classSourcedId)
      render_class_json Rclass.where(sourcedId: sourcedIds)
    end

    private

    def render_class_json(relations)
      relations = relations.where(sourcedId: INCLUDE_CLASSES) if INCLUDE_CLASSES.present?
      relations = relations.where.not(sourcedId: EXCLUDE_CLASSES) if EXCLUDE_CLASSES.present?
      relations = indexbase_with_condition(relations)
      render_json('Class', relations)
    end

    def strong_params
      params.require(:class).permit(:status, :dateLastModified, :title, :grades, :courseSourcedId, :classCode, :classType, :location, :schoolSourcedId, :termSourcedIds, :subjects, :subjectCodes, :periods)
    end
  end
end
