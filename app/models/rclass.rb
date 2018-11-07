# == Schema Information
#
# Table name: rclasses
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  grades           :string
#  courseSourcedId  :string
#  classCode        :string
#  classType        :string
#  location         :string
#  schoolSourcedId  :string
#  termSourcedIds   :string
#  subjects         :string
#  subjectCodes     :string
#  periods          :string
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Rclass < ApplicationRecord
  include Swagger::V1p1::ClassSchema
  before_create :generate_sourcedId
  belongs_to :course, foreign_key: :courseSourcedId, inverse_of: :rclasses
  belongs_to :school, foreign_key: :schoolSourcedId, class_name: 'Org', inverse_of: :rclasses
  # Assumption: Class does not belong to multiple terms
  belongs_to :term, foreign_key: :termSourcedIds, class_name: 'AcademicSession', inverse_of: :rclasses
  has_many :enrollments, foreign_key: :classSourcedId, inverse_of: :rclass
  has_many :students, -> { where('enrollments.role = ?', 'student') }, through: :enrollments, source: :user
  has_many :teachers, -> { where('enrollments.role = ?', 'teacher') }, through: :enrollments, source: :user
  # Validations for OneRoster bulk data
  validates :title, :application_id, :course, :school, :term, presence: true
  validates :classType, inclusion: { in: %w[homeroom scheduled]}
end
