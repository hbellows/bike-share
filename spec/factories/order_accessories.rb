FactoryBot.define do
  factory :order_accessory do
    quantity { rand(1..10) }
  end
end
