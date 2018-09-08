FactoryBot.define do
  factory :user do
    username {Faker::Name.first_name}
    email {"MyString@mystring.com"}
    password_digest {"test"}
    role {0}
  end
end
