# == Schema Information
#
# Table name: academic_sessions
#
#  sourcedId        :string           not null, primary key
#  status           :string
#  dateLastModified :datetime
#  title            :string
#  type             :string
#  startDate        :date
#  endDate          :date
#  parentSourcedId  :string
#  schoolYear       :integer
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  metadata         :text
#

require 'rails_helper'

RSpec.describe AcademicSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
