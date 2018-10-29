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
#  application_id      :integer          default(0)
#

class Course < ApplicationRecord
  include Swagger::V1p1::CourseSchema
  belongs_to :org, primary_key: :sourcedId, foreign_key: :orgSourcedId
  has_many :rclasses, primary_key: :sourcedId, foreign_key: :courseSourcedId
  # Validations for OneRoster bulk data
  before_create :generate_sourcedId
  validates :title, :orgSourcedId, presence: true
end
