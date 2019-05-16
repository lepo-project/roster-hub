class ApiDocsController < ApplicationController
    include Swagger::Blocks

    swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'RosterHub'
          key :description, 'Roster Management System based on IMS OneRoster specification'
          key :termsOfService, 'https://github.com/lepo-project/roster-hub/blob/master/LICENSE'
          contact do
            key :name, 'Oita University, Information Technology Center.'
          end
          license do
            key :name, 'GNU Affero General Public License v3.0'
          end
        end
        tag do
          key :name, 'RosterHub'
          key :description, 'IMS Oneroster API + original API'
          externalDocs do
            key :description, 'Find more info here'
            key :url, 'https://github.com/lepo-project/roster-hub'
          end
        end
        key :host, 'localhost:3000'
        key :basePath, '/ims/oneroster/v1p1'
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
