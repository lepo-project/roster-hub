class AddIndexToEnrollments < ActiveRecord::Migration[5.1]
  def change
    add_index :enrollments, :schoolSourcedId
  end
end
