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
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Enrollment < ApplicationRecord
  include Swagger::V1p1::EnrollmentSchema
  belongs_to :rclass, primary_key: :sourcedId, foreign_key: :classSourcedId
  belongs_to :user, primary_key: :sourcedId, foreign_key: :userSourcedId
end
