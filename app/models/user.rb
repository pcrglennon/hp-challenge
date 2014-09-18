class User < ActiveRecord::Base
  has_many :bikes, foreign_key: "owner_id"

  def rentals_as_renter
    self.class.joins("INNER JOIN rentals ON rentals.renter_id = users.id")
      .where(rentals: {renter_id: self.id})
  end
end