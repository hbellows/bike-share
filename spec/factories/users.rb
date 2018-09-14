FactoryBot.define do
  factory :user do
    username              { Faker::Name.first_name  }
    email                 { "MyString@mystring.com" }
    password              { 'password'              }
    password_confirmation { 'password'              }
    role                  { 0                       }
  end

  factory :admin, class: User do
    username              { 'admin'           }
    email                 { 'admin@admin.com' }
    password              { 'admin'           }
    password_confirmation { 'admin'           }
    role                  { 1                 }
  end
end
