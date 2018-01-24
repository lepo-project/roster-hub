FactoryBot.define do
    factory :enrollment do
        sourcedId       'es201701-oita-u'
        classSourcedId  'cl201701-oita-u'
        schoolSourcedId 'or01-oita-u'
        userSourcedId   'us001-oita-u'
        role            'teacher'
        primary         true
    end

    factory :random_enrollment, class: Enrollment do
        sourcedId   { Faker::Code.unique.asin }
        classSourcedId {FactoryBot.create(:random_rclass).sourcedId}
        schoolSourcedIds   'or01-oita-u'
        userSourceId    {FactoryBot.create(:random_user).sourcedId}
        role        'student'
        primary     true
    end
end