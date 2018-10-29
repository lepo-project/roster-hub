# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  enabledUser      :boolean
#  orgSourcedIds    :string
#  role             :string
#  username         :string
#  userIds          :string
#  givenName        :string
#  familyName       :string
#  middleName       :string
#  identifier       :string
#  email            :string
#  sms              :string
#  phone            :string
#  agentSourcedIds  :string
#  grades           :string
#  password         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  application_id   :integer          default(0)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
