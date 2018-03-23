class ApiDocsController < ApplicationController
    include Swagger::Blocks
    
    swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Swagger OnerosterAPI'
          key :description, 'An API that uses a one roster'
          key :termsOfService, 'https://github.com/j-nakashima/OneRosterCSVtoAPI/blob/master/LICENSE'
          contact do
            key :name, 'Oita University, Information Technology Center.'
          end
          license do
            key :name, 'GNU GENERAL PUBLIC LICENSE'
          end
        end
        tag do
          key :name, 'oneroster'
          key :description, 'Oneroster api'
          externalDocs do
            key :description, 'Find more info here'
            key :url, 'https://github.com/j-nakashima/OneRosterCSVtoAPI'
          end
        end
        key :host, 'localhost:3000/ims/oneroster/'
        key :basePath, 'v1p1'
        key :consumes, ['application/json']
        key :produces, ['application/json']
        extend Swagger::V1p1::Parameters
    end
    
    SWAGGERED_CLASSES = [
      V1p1::AcademicSessionsController,
      V1p1::CoursesController,
      V1p1::EnrollmentsController,
      V1p1::OrgsController,
      V1p1::RclassesController,
      V1p1::UsersController,
      AcademicSession,
      Course,
      Enrollment,
      Org,
      Rclass,
      User,
      self,
    ].freeze
    
    def index
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
end