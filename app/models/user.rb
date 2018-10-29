# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  enabledUser      :boolean
#  orgSourcedIds    :string
#  role             :string
#  username         :string
#  userIds          :string
#  givenName        :string
#  familyName       :string
#  middleName       :string
#  identifier       :string
#  email            :string
#  sms              :string
#  phone            :string
#  agentSourcedIds  :string
#  grades           :string
#  password         :string
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
  include Swagger::V1p1::UserSchema
  has_many :enrollments, primary_key: :sourcedId, foreign_key: :userSourcedId
  has_many :rclasses, through: :enrollments
  # Validations for OneRoster bulk data
  before_create :generate_sourcedId
  validates :enabledUser, :orgSourcedIds, :username, :givenName, :familyName, presence: true
  validates :role, inclusion: { in: %w[administrator aide guardian parent proctor relative student teacher]}
end
