require 'faker'

puts "Seeding begun\n"

def seed_users(count)
  puts "Seeding #{count} users"
  count.times.map do |i|
    User.create(name: Faker::Name.name)
  end
end

users = seed_users(100)
puts "User seed data completed"

def seed_bikes(users, count)
  puts "Seeding #{count} bikes"
  colors = %w(red orange yellow green blue indigo violet)
  categories = %w(road mountain hybrid bmx recumbent stationary penny-farthing)

  count.times.map do |i|
    Bike.create(owner: users.sample, color: colors.sample, category: categories.sample)
  end
end

bikes = seed_bikes(users, 400)
puts "Bike seed data completed"

def rental_dates
  # Flip a coin to create start_date in past or future
  if [1, 2].sample == 1
    start_date = Faker::Number.number(1).to_i.weeks.ago
  else
    start_date = Faker::Number.number(1).to_i.weeks.from_now
  end
  end_date = start_date + Faker::Number.number(2).to_i.days
  {start_date: start_date, end_date: end_date}
end

def seed_rentals(users, bikes, count)
  puts "Seeding #{count} rentals"
  count.times.map do |i|
    puts "#{i}/#{count} rentals created" if i > 0 && i % 1000 == 0
    dates = rental_dates
    Rental.create(renter: users.sample, bike: bikes.sample, start_date: dates[:start_date], end_date: dates[:end_date])
  end
end

seed_rentals(users, bikes, 5000)
puts "Rental seed data completed"