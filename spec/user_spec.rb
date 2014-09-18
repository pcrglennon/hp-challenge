require_relative './spec_helper'

RSpec.describe User do

  let(:user) { User.create(name: "Peter") }

  describe '#bikes' do
    it 'can add to #bikes' do
      bike = Bike.create(color: "Blue", category: "Road")
      user.bikes << bike
      user.save
      expect(user.bikes).to include(bike)
    end
  end

  describe 'rentals' do

    let(:mr_foo) { User.create(name: "Mr. Foo") }
    let(:bike) { Bike.create(category: "Road", color: "Blue", owner: user) }
    let(:other_bike) { Bike.create(category: "Mountain", color: "Red", owner: mr_foo) }
    let(:bike_rental) { Rental.create(renter: mr_foo, bike: bike, start_date: 3.days.ago, end_date: 2.days.ago) }
    let(:other_bike_rental) { Rental.create(renter: user, bike: other_bike, start_date: 3.days.ago, end_date: 2.days.ago) }

    describe '#rentals_as_owner' do

      let(:rentals_as_owner) { user.rentals_as_owner }

      it 'returns a list of rentals for its owned bikes' do
        expect(rentals_as_owner).to include(bike_rental)
        expect(rentals_as_owner).to_not include(other_bike_rental)
      end

      it 'is listed as owner on all #rentals_as_owner' do
        expect(rentals_as_owner.all? { |r| r.owner == user }).to be true
      end
    end

    describe '#rentals_as_renter' do

      let(:rentals_as_renter) { user.rentals_as_renter }

      it 'returns a list of rentals for its owned bikes' do
        expect(rentals_as_renter).to include(other_bike_rental)
        expect(rentals_as_renter).to_not include(bike_rental)
      end

      it 'is listed as renter on all #rentals_as_renter' do
        expect(user.rentals_as_renter.all? { |r| r.renter == user }).to be true
      end
    end
  end

end