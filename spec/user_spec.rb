require_relative './spec_helper'

RSpec.describe User do

  let(:user) { User.create(name: "Peter") }

  describe '#bikes' do
    it 'responds to #bikes' do
      expect(user).to respond_to(:bikes)
    end

    it 'can add bikes to its collection' do
      bike = Bike.create(color: "Blue", type: "Road")
      user.bikes << bike
      user.save
      expect(user.bikes).to include(bike)
    end
  end

  describe '#rentals_as_owner' do
    it 'responds to #rentals_as_owner' do
      expect(user).to respond_to(:rentals_as_owner)
    end

    it 'is listed as owner on all such rentals' do
      expect(user.rentals_as_owner.all? { |r| r.owner == user }).to be_true
    end
  end

  describe '#rentals_as_renter' do
    it 'responds to #rentals_as_renter' do
      expect(user).to respond_to(:rentals_as_renter)
    end

    it 'is listed as renter on all such rentals' do
      expect(user.rentals_as_renter.all? { |r| r.renter == user }).to be_true
    end
  end

end