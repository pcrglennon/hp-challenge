require 'faker'

def seed_users
  40.times.map do |i|
    User.create(name: Faker::Name.name)
  end
end

users = seed_users
puts "User seed data completed"

def seed_bikes(users)
  categories = %w(Road Mountain Hybrid BMX Recumbent Stationary Penny-farthing)

  60.times.map do |i|
    Bike.create(owner: users.sample, color: Faker::Commerce.color, category: categories.sample)
  end
end

bikes = seed_bikes(users)
puts "Bike seed data completed"

def rental_dates
  start_date = Faker::Number.number(1).to_i.weeks.ago
  end_date = start_date + Faker::Number.number(2).to_i.days
  {start_date: start_date, end_date: end_date}
end

def seed_rentals(users, bikes)
  120.times.map do |i|
    dates = rental_dates
    Rental.create(renter: users.sample, bike: bikes.sample, start_date: dates[:start_date], end_date: dates[:end_date])
  end
end

seed_rentals(users, bikes)
puts "Rental seed data completed"