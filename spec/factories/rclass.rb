FactoryBot.define do
  factory :rclass do
    sourcedId   'cl0001'
    title 'Test Class A'
    courseSourcedId 'co0001'
    classCode 'C401'
    classType 'scheduled'
    schoolSourcedId 'or0001'
    termSourcedIds 'as0001'
    periods '1-2'
  end

  factory :random_rclass, class: Rclass do
    sourcedId { Faker::Code.unique.asin }
    title { Faker::App.name }
    courseSourcedId { FactoryBot.create(:random_course).sourcedId }
    classCode { Faker::Code.unique.asin }
    classType 'scheduled'
    schoolSourcedId 'or0001'
    termSourcedIds { FactoryBot.create(:random_academic_session).sourcedId }
    periods '2-1'
  end
end
