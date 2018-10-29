# == Schema Information
#
# Table name: orgs
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  name             :string
#  type             :string
#  identifier       :string
#  parentSourcedId  :string
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Org, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
