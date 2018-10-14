module V1p1
  class AcademicSessionsController < V1p1::ApplicationController
    include Swagger::V1p1::AcademicSessionsApi
    def index
      indexbase(AcademicSession)
    end

    def term
      relations = AcademicSession.all
      relations = relations.where(type: 'term')
      relations = indexbase_with_condition(Org, relations)
      render_json('AcademicSession', relations)
    end
  end
end
