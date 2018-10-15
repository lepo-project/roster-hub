# == Schema Information
#
# Table name: rclasses
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  grades           :string
#  courseSourcedId  :string
#  classCode        :string
#  classType        :string
#  location         :string
#  schoolSourcedId  :string
#  termSourcedIds   :string
#  subjects         :string
#  subjectCodes     :string
#  periods          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Rclass < ApplicationRecord
  include Swagger::V1p1::ClassSchema
  belongs_to :course, primary_key: :sourcedId, foreign_key: :courseSourcedId
  belongs_to :school, primary_key: :sourcedId, foreign_key: :schoolSourcedId, class_name: Org
  has_many :enrollments, primary_key: :sourcedId, foreign_key: :classSourcedId
  has_many :students, -> { where('enrollments.role = ?', 'student') }, through: :enrollments, source: :user
  has_many :teachers, -> { where('enrollments.role = ?', 'teacher') }, through: :enrollments, source: :user
end
