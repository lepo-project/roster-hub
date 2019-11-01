# == Schema Information
#
# Table name: academic_sessions
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  type             :string
#  startDate        :date
#  endDate          :date
#  parentSourcedId  :string
#  schoolYear       :integer
#  metadata         :text
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class AcademicSession < ApplicationRecord
  include Swagger::V1p1::AcademicSessionSchema
  self.inheritance_column = :_type_disabled
  before_create :generate_sourcedId
  has_many :rclasses, foreign_key: :termSourcedIds, inverse_of: :term
  # Validations for OneRoster bulk data
  validates :title, :startDate, :endDate, :schoolYear, :application_id, presence: true
  validates :type, inclusion: { in: %w[gradingPeriod semester schoolYear term] }
end
