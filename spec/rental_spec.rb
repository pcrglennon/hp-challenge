require_relative './spec_helper'

RSpec.describe Rental do

  let(:user) { User.create(name: "Peter") }
  let(:mr_foo) { User.create(name: "Mr. Foo") }
  let(:bike) { Bike.create(category: "road", color: "blue", owner: user) }
  let(:rental) { Rental.create(renter: mr_foo, bike: bike, start_date: 3.days.ago, end_date: 2.days.ago) }

  describe '#owner' do
    it 'returns the owner of the bike being rented' do
      expect(rental.owner).to eq(user)
    end
  end

  describe '#status' do
    it 'is completed if end_date has passed' do
      expect(rental.status).to eq("Completed")
    end

    it 'is current if start_date has passed but end_date is upcoming' do
      current_rental = Rental.create(renter: mr_foo, bike: bike, start_date: 2.days.ago, end_date: 2.days.from_now)
      expect(current_rental.status).to eq("Current")
    end

    it 'is current if start_date is today' do
      current_rental = Rental.create(renter: mr_foo, bike: bike, start_date: Date.today, end_date: 2.days.from_now)
      expect(current_rental.status).to eq("Current")
    end

    it 'is current if end_date is today' do
      current_rental = Rental.create(renter: mr_foo, bike: bike, start_date: 2.days.ago, end_date: Date.today)
      expect(current_rental.status).to eq("Current")
    end

    it 'is upcoming if start_date is upcoming' do
      current_rental = Rental.create(renter: mr_foo, bike: bike, start_date: 2.days.from_now, end_date: 3.days.from_now)
      expect(current_rental.status).to eq("Upcoming")
    end
  end

  describe '::upcoming_joins, ::upcoming_includes, ::upcoming_naive' do

    let(:upcoming_bike_rental) { Rental.create(renter: mr_foo, bike: bike, start_date: 2.days.from_now, end_date: 3.days.from_now) }
    let(:upcoming_bike_rental_2) { Rental.create(renter: mr_foo, bike: bike, start_date: 5.days.from_now, end_date: 7.days.from_now) }
    let(:other_bike) { Bike.create(owner: mr_foo, category: "road", color: "red") }
    let(:upcoming_other_bike_rental) { Rental.create(renter: user, bike: other_bike, start_date: 2.days.from_now, end_date: 5.days.from_now) }
    let(:upcoming_other_bike_rental_2) { Rental.create(renter: user, bike: other_bike, start_date: 1.week.from_now, end_date: 2.weeks.from_now) }

    it 'should each return same information' do
      rentals_joins = Rental.upcoming_joins(category: "road")
      rentals_includes = Rental.upcoming_includes(category: "road")
      rentals_naive = Rental.upcoming_naive(category: "road")
      expect(rentals_joins).to eq(rentals_includes).and eq(rentals_naive)
    end

  end

end