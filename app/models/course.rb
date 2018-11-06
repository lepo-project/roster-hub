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
#  application_id      :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Course < ApplicationRecord
  include Swagger::V1p1::CourseSchema
  before_create :generate_sourcedId
  belongs_to :org, primary_key: :sourcedId, foreign_key: :orgSourcedId, inverse_of: :courses
  has_many :rclasses, primary_key: :sourcedId, foreign_key: :courseSourcedId, inverse_of: :course
  # Validations for OneRoster bulk data
  validates :sourcedId, :title, :org, presence: true
end
