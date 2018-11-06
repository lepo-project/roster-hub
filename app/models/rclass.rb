# == Schema Information
#
# Table name: rclasses
#
#  id               :integer          not null, primary key
#  sourcedId        :string
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
  belongs_to :course, primary_key: :sourcedId, foreign_key: :courseSourcedId, inverse_of: :rclasses
  belongs_to :school, primary_key: :sourcedId, foreign_key: :schoolSourcedId, class_name: 'Org', inverse_of: :rclasses
  # Assumption: Class does not belong to multiple terms
  belongs_to :term, primary_key: :sourcedId, foreign_key: :termSourcedIds, class_name: 'AcademicSession', inverse_of: :rclasses
  has_many :enrollments, primary_key: :sourcedId, foreign_key: :classSourcedId, inverse_of: :rclass
  has_many :students, -> { where('enrollments.role = ?', 'student') }, through: :enrollments, source: :user
  has_many :teachers, -> { where('enrollments.role = ?', 'teacher') }, through: :enrollments, source: :user
  # Validations for OneRoster bulk data
  validates :sourcedId, :title, :course, :school, :term, presence: true
  validates :classType, inclusion: { in: %w[homeroom scheduled]}
end
