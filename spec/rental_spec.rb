require_relative './spec_helper'

RSpec.describe Rental do

  let(:user) { User.create(name: "Peter") }
  let(:mr_foo) { User.create(name: "Mr. Foo") }
  let(:bike) { Bike.create(category: "Road", color: "Blue", owner: user) }
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

end