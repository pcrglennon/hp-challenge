class User < ActiveRecord::Base
  has_many :bikes, foreign_key: "owner_id"

  def rentals_as_owner

  end

  def rentals_as_renter
    Rental.joins("INNER JOIN users ON users.id = rentals.renter_id")
      .where(rentals: {renter_id: self.id})
  end
end