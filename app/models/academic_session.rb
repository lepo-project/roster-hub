# == Schema Information
#
# Table name: academic_sessions
#
#  id         :integer          not null, primary key
#  sourcedId  :string
#  status     :string
#  metadata   :text
#  title      :string
#  startDate  :date
#  endDate    :date
#  type       :string
#  schoolYear :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AcademicSession < ApplicationRecord
  validates :sourcedId, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :type, presence: true
  self.inheritance_column = :_type_disabled
end
