# == Schema Information
#
# Table name: orgs
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  name             :string
#  type             :string
#  identifier       :string
#  parentSourcedId  :string
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Org < ApplicationRecord
  include Swagger::V1p1::OrgSchema
  self.inheritance_column = :_type_disabled
  before_create :generate_sourcedId
  has_many :courses, primary_key: :sourcedId, foreign_key: :orgSourcedId, inverse_of: :org
  has_many :enrollments, primary_key: :sourcedId, foreign_key: :schoolSourcedId, inverse_of: :school
  has_many :rclasses, primary_key: :sourcedId, foreign_key: :schoolSourcedId, inverse_of: :school
  has_many :users, primary_key: :sourcedId, foreign_key: :orgSourcedIds, inverse_of: :org
  # Validations for OneRoster bulk data
  validates :sourcedId, :name, presence: true
  validates :type, inclusion: { in: %w[department school district local state national]}
end
