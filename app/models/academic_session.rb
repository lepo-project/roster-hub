# == Schema Information
#
# Table name: academic_sessions
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  type             :string
#  startDate        :date
#  endDate          :date
#  parentSourcedId  :string
#  schoolYear       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  application_id   :integer          default(0)
#

class AcademicSession < ApplicationRecord
  include Swagger::V1p1::AcademicSessionSchema
  self.inheritance_column = :_type_disabled
  # Validations for OneRoster bulk data
  before_create :generate_sourcedId
  validates :title, :startDate, :endDate, :schoolYear, presence: true
  validates :type, inclusion: { in: %w[gradingPeriod semester schoolYear term]}
end
