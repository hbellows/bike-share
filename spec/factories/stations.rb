FactoryBot.define do
  factory :station do
    name {Faker::Address.community}
    dock_count {Faker::Number.between(0, 50)}
    city {Faker::Address.city}
    installation_date {"2018-09-08 15:51:15"}
  end
end
