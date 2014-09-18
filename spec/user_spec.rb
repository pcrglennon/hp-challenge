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

  describe '#rentals_as_owner' do
    it 'is listed as owner on all #rentals_as_owner' do
      expect(user.rentals_as_owner.all? { |r| r.owner == user }).to be true
    end
  end

  describe '#rentals_as_renter' do
    it 'is listed as renter on all #rentals_as_renter' do
      expect(user.rentals_as_renter.all? { |r| r.renter == user }).to be true
    end
  end

end