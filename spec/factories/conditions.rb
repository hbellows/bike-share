FactoryBot.define do
  factory :condition do
    date {"2018-09-08 15:55:01"}
    max_temperature {Faker::Number.decimal(2)}
    mean_temperature {Faker::Number.decimal(2)}
    min_temperature {Faker::Number.decimal(2)}
    mean_humidity {Faker::Number.decimal(2)}
    mean_visibility {Faker::Number.decimal(2)}
    mean_wind_speed {Faker::Number.decimal(2)}
    precipitation {Faker::Number.decimal(2)}
  end
end
