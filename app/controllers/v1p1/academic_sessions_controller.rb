module V1p1
  class AcademicSessionsController < V1p1::ApplicationController
    include Swagger::V1p1::AcademicSessionsApi

    def term
      relations = AcademicSession.where(type: 'term')
      relations = indexbase_with_condition(relations)
      render_json('AcademicSession', relations)
    end
  end
end
