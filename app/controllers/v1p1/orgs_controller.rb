module V1p1
  class OrgsController < V1p1::ApplicationController
    def index
      indexbase(Org)
    end

    def schools
      datas = Org.all
      datas = datas.where(type: 'school')
      datas = indexbase_with_condition(Org, datas)
      render json: datas
    end
  end
end
