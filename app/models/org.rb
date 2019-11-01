# == Schema Information
#
# Table name: orgs
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  name             :string
#  type             :string
#  identifier       :string
#  parentSourcedId  :string
#  metadata         :text
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Org < ApplicationRecord
  include Swagger::V1p1::OrgSchema
  self.inheritance_column = :_type_disabled
  before_create :generate_sourcedId
  has_many :courses, foreign_key: :orgSourcedId, inverse_of: :org
  has_many :enrollments, foreign_key: :schoolSourcedId, inverse_of: :school
  has_many :rclasses, foreign_key: :schoolSourcedId, inverse_of: :school
  has_many :users, foreign_key: :orgSourcedIds, inverse_of: :org
  # Validations for OneRoster bulk data
  validates :name, :application_id, presence: true
  validates :type, inclusion: { in: %w[department school district local state national] }
end
