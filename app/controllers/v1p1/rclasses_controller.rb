module V1p1
  class RclassesController < V1p1::ApplicationController
    include Swagger::V1p1::ClassesApi

    def index
      relations = Rclass.all
      relations = relations.where(sourcedId: INCLUDE_CLASSES) if INCLUDE_CLASSES.present?
      relations = relations.where.not(sourcedId: EXCLUDE_CLASSES) if EXCLUDE_CLASSES.present?
      relations = indexbase_with_condition(relations)
      render_json('Class', relations)
    end

    def term
      relations = Rclass.where(termSourcedIds: params[:termSourcedId])
      relations = relations.where(sourcedId: INCLUDE_CLASSES) if INCLUDE_CLASSES.present?
      relations = relations.where.not(sourcedId: EXCLUDE_CLASSES) if EXCLUDE_CLASSES.present?
      relations = indexbase_with_condition(relations)
      render_json('Class', relations)
    end

    private

    def strong_params
      params.require(:class).permit(:status, :dateLastModified, :title, :grades, :courseSourcedId, :classCode, :classType, :location, :schoolSourcedId, :termSourcedIds, :subjects, :subjectCodes, :periods)
    end
  end
end
