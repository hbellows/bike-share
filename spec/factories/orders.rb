FactoryBot.define do
  factory :order do
    status { %w[ordered paid cancelled completed].sample }
  end
end
