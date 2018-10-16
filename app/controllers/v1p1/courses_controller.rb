module V1p1
  class CoursesController < V1p1::ApplicationController
    include Swagger::V1p1::CoursesApi
    def index
      indexbase(Course)
    end

    def school
      relations = Org.find_by(sourcedId: params[:orgSourcedId]).courses
      relations = indexbase_with_condition(Course, relations)
      render_json('Course', relations)
    end
  end
end
