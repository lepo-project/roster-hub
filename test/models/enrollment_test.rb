# == Schema Information
#
# Table name: enrollments
#
#  id              :integer          not null, primary key
#  sourcedId       :string
#  status          :string
#  metadata        :text
#  classSourcedId  :string
#  schoolSourcedId :string
#  userSourcedId   :string
#  role            :string
#  primary         :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
