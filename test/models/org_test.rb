# == Schema Information
#
# Table name: orgs
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  name             :string
#  type             :string
#  identifier       :string
#  parentSourcedId  :string
#  metadata         :text
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class OrgTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
