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
#  metadata         :text
#  application_id   :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class AcademicSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
