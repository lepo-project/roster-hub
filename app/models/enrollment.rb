# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  classSourcedId   :string
#  schoolSourcedId  :string
#  userSourcedId    :string
#  role             :string
#  primary          :boolean
#  beginDate        :date
#  endDate          :date
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Enrollment < ApplicationRecord
  include Swagger::V1p1::EnrollmentSchema
  belongs_to :rclass, primary_key: :sourcedId, foreign_key: :classSourcedId
  belongs_to :school, primary_key: :sourcedId, foreign_key: :schoolSourcedId, class_name: 'Org'
  belongs_to :user, primary_key: :sourcedId, foreign_key: :userSourcedId
  # Validations for OneRoster bulk data
  before_create :generate_sourcedId
  validates :classSourcedId, :schoolSourcedId, :userSourcedId, presence: true
  validates :role, inclusion: { in: %w[administrator aide guardian parent proctor relative student teacher]}
end
