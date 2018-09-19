![ruby 2.4.1](https://img.shields.io/badge/ruby-2.4.1-red.svg)
![rails_ 5.1.6](https://img.shields.io/badge/rails_-5.1.6-blue.svg)

Bike Share README
Abstract
This application uses Ruby on Rails and ActiveRecord to analyze data from a Bay Area bike share program. Data explored includes general stats along with usage stats. The usage stats will be particularly helpful in creating relationships with local business for mutual benefit. As well as showing financial impact for immediate communities near a proposed new bike docking station. Data also includes weather information for all days.

Also included is a bike shop where visitors are able to peruse bike accessories. Visitors are able to create an account in order to login and checkout their cart.

System Dependencies ;
 - Ruby Version > 2.4.0
 - Rails 5.1.6

Gems:
 - FactoryBot (test) 
 https://github.com/thoughtbot/factory_bot
 - Rails-RSpec for tests (test) 
https://github.com/rspec/rspec-rails
 - Launchy (test) 
https://github.com/copiousfreetime/launchy
 - Bootstrap (production) 
https://getbootstrap.com
 - Shoulda-Matchers (test) https://github.com/thoughtbot/shoulda-matchers
 - FriendlyID (production) 
https://github.com/norman/friendly_id
 - Faker (test) 
 https://github.com/stympy/faker
 - BCrpyt (production) - (uncomment this line in the gemfile: gem 'bcrypt', '~> 3.1.7')
 - Will_Paginate (production) https://github.com/mislav/will_paginate
 - DatabaseCleaner (test) https://github.com/DatabaseCleaner/database_cleaner
 - Pry (test) 
 https://github.com/pry/pry
 - Figaro (production/test) 
 https://github.com/laserlemon/figaro
 - PostgreSQL (all) 
 https://www.postgresql.org/
 - Capybara (test) 
 https://github.com/teamcapybara/capybara
 - SimpleCov (test) 
 https://github.com/colszowka/simplecov
 - Carrierwave (all) https://github.com/carrierwaveuploader/carrierwave
 - JQuery Rails (all) 
 https://github.com/rails/jquery-rails

Testing:
 - Run `rspec` for the test suite
 - SimpleCov data

Initial Setup:
 - Clone this repository git clone https://github.com/mikecm1141/bike-share
 - Bundle install/update
 - Rake DB Drop Create Migrate Seed

Database Initialization: 
 - CSV files load random samples of data, with a cutoff at 5,000 lines to keep the app heroku deployable.
 - Default accounts for admin and user (like a demo)
 - Default admin account appears in the seed file, and will seed to the database:
```ruby
# Create default admin
User.create!(
 full_name: 'Admin Admin',
 username: 'admin',
 password: 'password',
 password_confirmation: 'password',
 email: 'admin@admin.com',
 role: 1
)
```
Business Analytics: Robust data collection, with data points ranging from daily, regional weather conditions, to trip minute by minute trip durations. Deep data analysis to help drive business growth.
Track daily average rides:
```ruby
  def self.avg_rides_breakdown(min, max, attribute)
   trip_count = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).length
   trip_total = Trip.select("start_date, count(trips.id) as count").joins("join conditions ON conditions.date=trips.start_date").where("#{attribute} between ? and ?", min, max).group(:start_date).size.values.sum
   if trip_total > 0 && trip_count > 0
     trip_total / trip_count.to_f
   else
     0
   end
 end
 ```
Track rides by weather condition:
```ruby
  def self.precip_breakdown
    ranges = {'half'=>{min: 0, max: 0.49},'one'=>{min: 0.5, max: 0.99},'one_half'=>{min: 1, max: 1.49},'two'=>{min: 1.5, max: 1.99},'two_half'=>{min: 2, max: 2.49},'three'=>{min: 2.5, max: 2.99},'three_half'=>{min: 3, max: 3.49}}
    precipitation_values = Hash.new { |hash, key| hash[key] = Hash.new(&hash.default_proc) }
    ranges.each do |precip_range, min_max|
      precipitation_values['max_rides'][precip_range] = Condition.max_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
      precipitation_values['avg_rides'][precip_range] = Condition.avg_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
      precipitation_values['min_rides'][precip_range] = Condition.min_rides_breakdown(min_max[:min], min_max[:max], 'precipitation')
    end
    precipitation_values
  end
  ```
Pull Request Template/Fork Repository
The repositiory comes with a a pull request template. If you'd like to demo the appliation, just fork a copy, take it for a ride, and leave us feedback in your pull request.

Contact Information
Feel free to contact us with any questions, comments, or suggestions:

Abdulla: https://github.com/abdullaqudrat
Andrew: https://github.com/andrewetobin
Harper: https://github.com/hbellows
Mike: https://github.com/mikecm1141
