FactoryBot.define do
  factory :accessory do
    name {Faker::Commerce.product_name}
    price {Faker::Commerce.price}
    description {Faker::Commerce.material}
    image {"bike_image.jpg"}
    retired? { false }
  end
end
