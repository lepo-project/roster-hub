FactoryBot.define do
    factory :user do
        sourcedId   'us001-oita-u'
        enabledUser true
        orgSourcedIds 'or01-oita-u'
        role    'student'
        username    't5001'
        givenName   '大分　太郎'
        familyName  '大分　太郎'
        email   't5001@oita-u.ac.jp'
    end

    factory :random_user, class: User do
        sourcedId   { Faker::Code.unique.asin }
        enabledUser true
        orgSourcedIds   'or01-oita-u'
        role        'student'
        #username    { Faker::Internet.user_name(8..10) }
        givenName   { Faker::Name.first_name }
        familyName  { Faker::Name.last_name}
        #email       { Faker::Internet.safe_email }
        sequence :email do |n|
            "t1700#{n}@oita-u.ac.jp"
        end
        sequence :username do |n|
            "t1700#{n}"
        end
    end
end