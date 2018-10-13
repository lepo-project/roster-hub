module V1p1
  class OrgsController < V1p1::ApplicationController
    include Swagger::V1p1::OrgsApi

    def index
      indexbase(Org)
    end

    def schools
      datas = Org.all
      datas = datas.where(type: 'school')
      datas = indexbase_with_condition(Org, datas)
      render json: datas, except: %i[id created_at updated_at]
    end
  end
end
