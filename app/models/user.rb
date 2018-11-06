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
  before_create :generate_sourcedId
  # Assumption: User does not belong to multiple orgs
  belongs_to :org, primary_key: :sourcedId, foreign_key: :orgSourcedIds, inverse_of: :users
  has_many :enrollments, primary_key: :sourcedId, foreign_key: :userSourcedId, inverse_of: :user
  has_many :rclasses, through: :enrollments
  # Validations for OneRoster bulk data
  validates :sourcedId, :username, :givenName, :familyName, :org, presence: true
  validates :enabledUser, inclusion: { in: [true, false] }
  validates :role, inclusion: { in: %w[administrator aide guardian parent proctor relative student teacher]}
end
