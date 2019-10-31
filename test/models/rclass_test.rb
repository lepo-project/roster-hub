# == Schema Information
#
# Table name: rclasses
#
#  sourcedId        :string           not null, primary key
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
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  metadata         :text
#

require 'test_helper'

class RclassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
