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

require 'test_helper'

class AcademicSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
