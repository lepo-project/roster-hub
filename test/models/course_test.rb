# == Schema Information
#
# Table name: courses
#
#  sourcedId           :string           not null, primary key
#  status              :string
#  dateLastModified    :datetime
#  schoolYearSourcedId :string
#  title               :string
#  courseCode          :string
#  grades              :string
#  orgSourcedId        :string
#  subjects            :string
#  subjectCodes        :string
#  application_id      :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  metadata            :text
#

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
