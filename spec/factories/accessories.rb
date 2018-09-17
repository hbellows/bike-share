FactoryBot.define do
  factory :accessory do
    name {Faker::Commerce.product_name}
    price { rand(1..200) }
    description {Faker::Commerce.material}
    image {"bike_image.jpg"}
    retired? { false }
  end
end
