FactoryBot.define do
  factory :course do
    sourcedId 'co0001'
    title 'test course'
    courseCode 'CC401'
    orgSourcedId 'or0001'
  end

  factory :random_course, class: Course do
    sourcedId   { Faker::Code.unique.asin }
    title       { Faker::App.name }
    courseCode  { Faker::Code.unique.asin }
    orgSourcedId 'or0001'
  end
end
