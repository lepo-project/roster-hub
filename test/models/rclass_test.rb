# == Schema Information
#
# Table name: rclasses
#
#  id              :integer          not null, primary key
#  sourcedId       :string
#  status          :string
#  metadata        :text
#  title           :string
#  courseSourcedId :string
#  classCode       :string
#  classType       :string
#  schoolSourcedId :string
#  termSourcedIds  :string
#  periods         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class RclassTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
