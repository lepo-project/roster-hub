# == Schema Information
#
# Table name: orgs
#
#  id               :integer          not null, primary key
#  sourcedId        :string
#  status           :string
#  dateLastModified :datetime
#  name             :string
#  type             :string
#  identifier       :string
#  parentSourcedId  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Org < ApplicationRecord
  include Swagger::V1p1::OrgSchema
  self.inheritance_column = :_type_disabled
end
