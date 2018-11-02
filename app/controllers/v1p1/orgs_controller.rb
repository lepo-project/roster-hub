module V1p1
  class OrgsController < V1p1::ApplicationController
    include Swagger::V1p1::OrgsApi

    def schools
      relations = Org.where(type: 'school')
      relations = indexbase_with_condition(relations)
      render_json('Org', relations)
    end

    private

    def strong_params
      params.require(:org).permit(:status, :dateLastModified, :name, :type, :identifier, :parentSourcedId)
    end
  end
end
