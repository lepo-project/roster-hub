FactoryBot.define do
    factory :course do
        sourcedId   'co201701-oita-u'
        title 'テストコース'
        courseCode 'CC401'
        orgSourcedId    'or01-oita-u'
    end

    factory :random_course, class: Course do
        sourcedId   { Faker::Code.unique.asin }
        title       { Faker::App.name }
        courseCode  { Faker::Code.unique.asin }
        orgSourcedId    'or01-oita-u'
    end
end