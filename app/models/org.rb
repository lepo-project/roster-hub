# == Schema Information
#
# Table name: orgs
#
#  id         :integer          not null, primary key
#  sourcedId  :string
#  status     :string
#  metadata   :text
#  name       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Org < ApplicationRecord
  self.inheritance_column = :_type_disabled
end
