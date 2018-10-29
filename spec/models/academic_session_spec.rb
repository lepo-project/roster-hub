# == Schema Information
#
# Table name: academic_sessions
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  type             :string
#  startDate        :date
#  endDate          :date
#  parentSourcedId  :string
#  schoolYear       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  application_id   :integer          default(0)
#

require 'rails_helper'

RSpec.describe AcademicSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
