FactoryBot.define do
  factory :academic_session do
    sourcedId   'as0001'
    title       '2019-first'
    type        'term'
    startDate   '2019-04-01'
    endDate     '2019-10-01'
    schoolYear  2020
  end

  factory :random_academic_session, class: AcademicSession do
    sourcedId   { Faker::Code.unique.asin }
    title       { Faker::App.unique.name }
    type        'term'
    startDate   { Faker::Date.between(1.year.ago, Date.today) }
    endDate     { Faker::Date.between(Date.today, 1.year.from_now) }
    schoolYear  2020
  end
end
