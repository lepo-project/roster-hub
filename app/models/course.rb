# == Schema Information
#
# Table name: courses
#
#  id                  :integer          not null, primary key
#  sourcedId           :string
#  status              :string
#  dateLastModified    :datetime
#  schoolYearSourcedId :string
#  title               :string
#  courseCode          :string
#  grades              :string
#  orgSourcedId        :string
#  subjects            :string
#  subjectCodes        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Course < ApplicationRecord
  include Swagger::V1p1::CourseSchema
end
