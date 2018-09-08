FactoryBot.define do
  factory :trip do
    duration {Faker::Number.between(1, 25)}
    start_date {"2018-09-08 16:02:50"}
    start_station_id {Faker::Number.between(1, 10)}
    end_date {"2018-09-08 16:02:50"}
    end_station_id {Faker::Number.between(1, 10)}
    bike_id {Faker::Number.between(1, 200)}
    subscription_type {Faker::Number.between(0, 1)}
    zip_code {Faker::Address.zip_code}
  end
end
