module V1p1
  class RclassesController < V1p1::ApplicationController
    include Swagger::V1p1::ClassesApi
    def index
      datas = Rclass.all
      datas = datas.where(sourcedId: INCLUDE_CLASSES) unless INCLUDE_CLASSES.empty?
      datas = indexbase_with_condition(Rclass, datas)
      render json: datas
    end

    def term
      datas = Rclass.all
      datas = datas.where(sourcedId: INCLUDE_CLASSES) unless INCLUDE_CLASSES.empty?
      datas = datas.where(termSourcedIds: params[:termSourcedId])
      datas = indexbase_with_condition(Rclass, datas)
      render json: datas
    end
  end
end
