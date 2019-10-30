FactoryBot.define do
  factory :user do
    sourcedId   'us0001'
    enabledUser true
    orgSourcedIds 'or0001'
    role 'student'
    username 'user01'
    givenName 'GivenName01'
    familyName 'FamilyName01'
    email 'user01@sample-u.ac.jp'
  end

  factory :random_user, class: User do
    sourcedId   { Faker::Code.unique.asin }
    enabledUser true
    orgSourcedIds 'or0001'
    role 'student'
    # username { Faker::Internet.user_name(8..10) }
    givenName { Faker::Name.first_name }
    familyName { Faker::Name.last_name }
    # email { Faker::Internet.safe_email }
    sequence :email do |n|
      "user00#{n}@sample-u.ac.jp"
    end
    sequence :username do |n|
      "user00#{n}"
    end
  end
end
