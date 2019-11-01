FactoryBot.define do
  factory :enrollment do
    sourcedId 'en0001'
    classSourcedId 'cl0001'
    schoolSourcedId 'or0001'
    userSourcedId 'us0001'
    role 'teacher'
    primary true
  end

  factory :random_enrollment, class: Enrollment do
    sourcedId { Faker::Code.unique.asin }
    classSourcedId { FactoryBot.create(:random_rclass).sourcedId }
    schoolSourcedIds 'or0001'
    userSourceId { FactoryBot.create(:random_user).sourcedId }
    role 'student'
    primary true
  end
end
