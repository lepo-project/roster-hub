# == Schema Information
#
# Table name: courses
#
#  id           :integer          not null, primary key
#  sourcedId    :string
#  status       :string
#  metadata     :text
#  title        :string
#  courseCode   :string
#  orgSourcedId :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
