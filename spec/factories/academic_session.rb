FactoryBot.define do
    factory :academic_session do
        sourcedId   'as201701-oita-u'
        title       '2017-first'
        type        'term'
        startDate   '2017/4/1'
        endDate     '2017/9/30'
        schoolYear  2018
    end

    factory :random_academic_session, class: AcademicSession do
        sourcedId   { Faker::Code.unique.asin }
        title       { Faker::App.unique.name }
        type        'term'
        startDate   { Faker::Date.between(1.year.ago, Date.today) }
        endDate     { Faker::Date.between(Date.today, 1.year.from_now) }
        schoolYear  2018
    end
end