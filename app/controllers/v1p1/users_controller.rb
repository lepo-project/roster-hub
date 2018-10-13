module V1p1
  class UsersController < V1p1::ApplicationController
    include Swagger::V1p1::UsersApi

    def index
      indexbase(User)
    end

    def students
      datas = User.all
      datas = datas.where(role: 'student')
      datas = indexbase_with_condition(Org, datas)
      render json: datas, except: %i[id created_at updated_at]
    end

    def teachers
      datas = User.all
      datas = datas.where(role: 'teacher')
      datas = indexbase_with_condition(Org, datas)
      render json: datas, except: %i[id created_at updated_at]
    end
  end
end
