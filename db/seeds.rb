require 'csv'

station_csv = Rails.root.join('lib', 'seeds', 'station.csv')
trip_csv = Rails.root.join('lib', 'seeds', 'trip.csv')
weather_csv = Rails.root.join('lib', 'seeds', 'weather.csv')

# Load accessories in
puts "Seeding Accessories Table"
accessories = [
  'Tire',
  'Rim',
  'Bike Seat',
  'Pedals',
  'Chain',
  'Air Pump',
  'Bike Tool Set',
  'Headlamp',
  'Helmet',
  'Chain Grease',
  'Patch Kit',
  'Water Bottle Holder',
  'Grips',
  'Taillight',
  'Rack'
]

accessory_array = []
accessories.each do |accessory|
  item = Accessory.create!(
    name: accessory,
    price: rand(10..200),
    description: "#{accessory} is what you need for your biking adventures.",
    image: 'bike_image.jpg',
    retired?: false
  )
  accessory_array << item
end

# Create a few default users
puts "Creating a few default users"
users = []
10.times do |n|
  user = User.create!(
    username: "User#{n}",
    email: "useremail#{n}@email.com",
    password: 'pass',
    password_confirmation: 'pass'
  )
  users << user
end

# Create some default orders
puts "Creating some default orders"
order_statuses = %w[completed paid ordered cancelled]
20.times do
  order = Order.create!(status: order_statuses.sample, user_id: users.sample.id)
  rand(1..5).times do
    random_accessory = accessory_array.sample
    order.order_accessories.create(
      quantity: rand(1..5),
      unit_price: random_accessory.price,
      accessory_id: random_accessory.id
    )
  end
end

# Load stations in
puts "Seeding Stations table"
CSV.foreach(station_csv, headers: true, header_converters: :symbol) do |row|
  Station.create!(
    id:                row[:id],
    dock_count:        row[:dock_count],
    name:              row[:name],
    city:              row[:city],
    installation_date: Date.strptime(row[:installation_date], '%m/%d/%Y')
  )
end

# Load conditions in
puts "Seeding conditions table"
CSV.foreach(weather_csv, headers: true, header_converters: :symbol) do |row|
  Condition.create!(
    date:             Date.strptime(row[:date], '%m/%d/%Y'),
    max_temperature:  row[:max_temperature_f].to_f,
    mean_temperature: row[:mean_temperature_f].to_f,
    min_temperature:  row[:min_temperature_f].to_f,
    mean_humidity:    row[:mean_humidity].to_f,
    mean_visibility:  row[:mean_visibility_miles].to_f,
    mean_wind_speed:  row[:mean_wind_speed_mph].to_f,
    precipitation:    row[:precipitation_inches].to_f
  )
end

# Load trips in with counter
row_count = 0
puts "Seeding Trips table"
CSV.foreach(trip_csv, headers: true, header_converters: :symbol) do |row|
  if rand(1..50) == 35
    Trip.create!(
      duration:          row[:duration].to_i,
      start_date:        Date.strptime(row[:start_date], '%m/%d/%Y'),
      start_station_id:  row[:start_station_id].to_i,
      end_date:          Date.strptime(row[:end_date], '%m/%d/%Y'),
      end_station_id:    row[:end_station_id].to_i,
      bike_id:           row[:bike_id].to_i,
      subscription_type: row[:subscription_type].to_i,
      zip_code:          row[:zip_code].to_i
    )
    row_count += 1
  end
  break if row_count >= 5500
end

# Create default admin
User.create!(
  username: 'admin',
  password: 'password',
  password_confirmation: 'password',
  email: 'admin@admin.com',
  role: 1
)
