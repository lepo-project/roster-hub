# == Schema Information
#
# Table name: courses
#
#  sourcedId           :string           not null, primary key
#  status              :string
#  dateLastModified    :datetime
#  schoolYearSourcedId :string
#  title               :string
#  courseCode          :string
#  grades              :string
#  orgSourcedId        :string
#  subjects            :string
#  subjectCodes        :string
#  application_id      :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  metadata            :json
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
