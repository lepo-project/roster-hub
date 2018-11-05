module V1p1
  class UsersController < V1p1::ApplicationController
    include Swagger::V1p1::UsersApi

    def students
      relations = User.where(role: 'student')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def students_for_class
      relations = Rclass.find_by(sourcedId: params[:classSourcedId]).students
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def students_for_school
      # Assumption: User does not belong to multiple orgs
      relations = User.where(orgSourcedIds: params[:schoolSourcedId], role: 'student')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def teachers
      relations = User.where(role: 'teacher')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def teachers_for_class
      relations = Rclass.find_by(sourcedId: params[:classSourcedId]).teachers
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    def teachers_for_school
      # Assumption: User does not belong to multiple orgs
      relations = User.where(orgSourcedIds: params[:schoolSourcedId], role: 'teacher')
      relations = indexbase_with_condition(relations)
      render_json('User', relations)
    end

    private

    def strong_params
      params.require(:user).permit(:status, :dateLastModified, :enabledUser, :orgSourcedIds, :role, :username, :userIds, :givenName, :familyName, :middleName, :identifier, :email, :sms, :phone, :agentSourcedIds, :grades, :password)
    end
  end
end
