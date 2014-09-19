class User < ActiveRecord::Base
  has_many :bikes, foreign_key: "owner_id"

  def rentals_as_owner
    Rental.joins("INNER JOIN bikes ON bikes.id = rentals.bike_id")
      .where(bike_id: [self.bike_ids])
  end

  def rentals_as_renter
    Rental.joins("INNER JOIN users ON users.id = rentals.renter_id")
      .where(rentals: {renter_id: self.id})
  end

  def self.with_bikes_joins(bike_params)
    User.joins(:bikes).where(bikes: bike_params)
  end

  def self.with_bikes_includes(bike_params)
    User.includes(:bikes).where(bikes: bike_params)
  end

  def self.with_bikes_naive(bike_params)
    # Get all bikes which match bike_params
    matching_bikes = Bike.all.select do |bike|
      bike_params.all? { |k, v| bike.send(k.to_sym) == v }
    end
    matching_bikes.collect { |bike| bike.owner }.compact.uniq
  end

end