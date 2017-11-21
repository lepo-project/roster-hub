# == Schema Information
#
# Table name: orgs
#
#  id         :integer          not null, primary key
#  sourcedId  :string
#  status     :string
#  metadata   :text
#  name       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OrgTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
