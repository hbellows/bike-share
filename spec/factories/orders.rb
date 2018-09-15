FactoryBot.define do
  factory :order do
    status         { %w[ordered paid cancelled completed].sample }
    street_address { '122 Fake Address Avenue'                   }
    city           { 'Denver'                                    }
    state          { 'CO'                                        }
    zip_code       { 80401                                       }
  end
end
