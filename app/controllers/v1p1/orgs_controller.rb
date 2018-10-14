module V1p1
  class OrgsController < V1p1::ApplicationController
    include Swagger::V1p1::OrgsApi

    def index
      indexbase(Org)
    end

    def schools
      relations = Org.all
      relations = relations.where(type: 'school')
      relations = indexbase_with_condition(Org, relations)
      render_json('Org', relations)
    end
  end
end
