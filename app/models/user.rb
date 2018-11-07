# == Schema Information
#
# Table name: users
#
#  sourcedId        :string           not null, primary key
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
  before_create :generate_sourcedId
  # Assumption: User does not belong to multiple orgs
  belongs_to :org, foreign_key: :orgSourcedIds, inverse_of: :users
  has_many :enrollments, foreign_key: :userSourcedId, inverse_of: :user
  has_many :rclasses, through: :enrollments
  # Validations for OneRoster bulk data
  validates :username, :givenName, :familyName, :application_id, :org, presence: true
  validates :enabledUser, inclusion: { in: [true, false] }
  validates :role, inclusion: { in: %w[administrator aide guardian parent proctor relative student teacher]}
end
