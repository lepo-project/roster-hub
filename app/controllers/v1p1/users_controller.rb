module V1p1
  class UsersController < V1p1::ApplicationController
    include Swagger::V1p1::UsersApi

    def index
      indexbase(User)
    end

    def students
      relations = User.all
      relations = relations.where(role: 'student')
      relations = indexbase_with_condition(Org, relations)
      render_json('User', relations)
    end

    def teachers
      relations = User.all
      relations = relations.where(role: 'teacher')
      relations = indexbase_with_condition(Org, relations)
      render_json('User', relations)
    end
  end
end
