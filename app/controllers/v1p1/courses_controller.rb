module V1p1
  class CoursesController < V1p1::ApplicationController
    include Swagger::V1p1::CoursesApi
    def index
      indexbase(Course)
    end

    # def school
    #   datas = Course.all
    #   datas = datas.where(type: 'school')
    #   datas = indexbase_with_condition(Course, datas)
    #   render json: datas, except: %i[id created_at updated_at]
    # end
  end
end
