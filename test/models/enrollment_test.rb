# == Schema Information
#
# Table name: enrollments
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  classSourcedId   :string
#  schoolSourcedId  :string
#  userSourcedId    :string
#  role             :string
#  primary          :boolean
#  beginDate        :date
#  endDate          :date
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  metadata         :json
#

require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
