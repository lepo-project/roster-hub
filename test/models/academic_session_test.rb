# == Schema Information
#
# Table name: academic_sessions
#
#  id         :integer          not null, primary key
#  sourcedId  :string
#  status     :string
#  metadata   :text
#  title      :string
#  startDate  :date
#  endDate    :date
#  type       :string
#  schoolYear :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AcademicSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
