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
#  schoolYear       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class AcademicSession < ApplicationRecord
    self.inheritance_column = :_type_disabled
end
