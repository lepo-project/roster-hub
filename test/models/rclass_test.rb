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
#  application_id   :integer          default(0)
#

require 'test_helper'

class RclassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
