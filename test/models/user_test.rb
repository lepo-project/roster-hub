# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  sourcedId     :string
#  status        :string
#  metadata      :text
#  enabledUser   :boolean
#  orgSourcedIds :string
#  role          :string
#  username      :string
#  givenName     :string
#  familyName    :string
#  email         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end