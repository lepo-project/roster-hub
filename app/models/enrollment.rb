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
  before_create :generate_sourcedId
  belongs_to :rclass, primary_key: :sourcedId, foreign_key: :classSourcedId, inverse_of: :enrollments
  belongs_to :school, primary_key: :sourcedId, foreign_key: :schoolSourcedId, class_name: 'Org', inverse_of: :enrollments
  belongs_to :user, primary_key: :sourcedId, foreign_key: :userSourcedId, inverse_of: :enrollments
  # Validations for OneRoster bulk data
  # ATTENTION: If validates for presence begins with association, NO validations are executed for mariaDB!(NEED CHECK)
  validates :sourcedId, :rclass, :school, :user, presence: true
  validates :role, inclusion: { in: %w[administrator aide guardian parent proctor relative student teacher]}
end
