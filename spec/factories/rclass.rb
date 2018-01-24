FactoryBot.define do
    factory :rclass do
        sourcedId   'cl201701-oita-u'
        title 'テストコース-A'
        courseSourcedId 'co201701-oita-u'
        classCode 'C401'
        classType 'scheduled'
        schoolSourcedId    'or01-oita-u'
        termSourcedIds 'as201703-oita-u'
        periods 9
    end

    factory :random_rclass, class: Rclass do
        sourcedId   { Faker::Code.unique.asin }
        title       { Faker::App.name }
        courseSourcedId {FactoryBot.create(:random_course).sourcedId}
        classCode  { Faker::Code.unique.asin }
        classType   'scheduled'
        schoolSourcedId    'or01-oita-u'
        termSourcedIds {FactoryBot.create(:random_academic_session).sourcedId}
        periods 9
    end
end