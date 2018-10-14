module V1p1
  class AcademicSessionsController < V1p1::ApplicationController
    include Swagger::V1p1::AcademicSessionsApi
    def index
      indexbase(AcademicSession)
    end

    def term
      datas = AcademicSession.all
      datas = datas.where(type: 'term')
      datas = indexbase_with_condition(Org, datas)
      render_json('AcademicSession', datas)
    end
  end
end
