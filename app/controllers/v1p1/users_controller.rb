module V1p1
  class UsersController < V1p1::ApplicationController
    include Swagger::V1p1::UsersApi

    def students
      relations = User.where(role: 'student')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def students_in_class
      relations = Rclass.find_by(sourcedId: params[:classSourcedId]).students
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def teachers
      relations = User.where(role: 'teacher')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def teachers_in_class
      relations = Rclass.find_by(sourcedId: params[:classSourcedId]).teachers
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end
  end
end
