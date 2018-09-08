FactoryBot.define do
  factory :accessory do
    name {Faker::Commerce.product_name}
    price {Faker::Commerce.price}
    description {Faker::Commerce.material}
    image {"image.jpg"}
  end
end
