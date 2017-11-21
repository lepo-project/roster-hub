# == Schema Information
#
# Table name: rclasses
#
#  id              :integer          not null, primary key
#  sourcedId       :string
#  status          :string
#  metadata        :text
#  title           :string
#  courseSourcedId :string
#  classCode       :string
#  classType       :string
#  schoolSourcedId :string
#  termSourcedIds  :string
#  periods         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Rclass < ApplicationRecord
end
