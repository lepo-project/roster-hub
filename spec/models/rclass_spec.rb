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
#  metadata         :text
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Rclass, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
