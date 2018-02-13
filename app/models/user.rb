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
#  givenName        :string
#  familyName       :string
#  email            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ApplicationRecord
end
