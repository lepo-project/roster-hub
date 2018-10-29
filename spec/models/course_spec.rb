# == Schema Information
#
# Table name: courses
#
#  id                  :integer          not null, primary key
#  sourcedId           :string
#  status              :string
#  dateLastModified    :datetime
#  schoolYearSourcedId :string
#  title               :string
#  courseCode          :string
#  grades              :string
#  orgSourcedId        :string
#  subjects            :string
#  subjectCodes        :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  application_id      :integer          default(0)
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
