# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  classSourcedId   :string
#  schoolSourcedId  :string
#  userSourcedId    :string
#  role             :string
#  primary          :boolean
#  beginDate        :date
#  endDate          :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  application_id   :integer          default(0)
#

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
