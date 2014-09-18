require_relative './spec_helper'

RSpec.describe Bike do

  let(:user) { User.create(name: "Peter") }
  let(:bike) { Bike.create(category: "Road", color: "Blue", owner: user) }

  describe '#owner' do
    it 'has an owner' do
      expect(bike.owner).to eq(user)
    end
  end

  describe '#rentals' do

    let(:mr_foo) { User.create(name: "Mr. Foo") }
    before do
      Rental.create(renter: mr_foo, bike: bike, start_date: 3.days.ago, end_date: 2.days.ago)
      Rental.create(renter: mr_foo, bike: bike, start_date: 3.days.from_now, end_date: 4.days.from_now)
    end

    it 'returns a list of all its rentals' do
      expect(bike.rentals.length).to eq(2)
    end

    it 'only knows about its own rentals' do
      other_bike = Bike.create(category: "Mountain", color: "Red", owner: user)
      other_rental = Rental.create(renter: mr_foo, bike: other_bike, start_date: 6.days.from_now, end_date: 8.days.from_now)

      expect(bike.rentals).to_not include(other_rental)
    end
  end

end