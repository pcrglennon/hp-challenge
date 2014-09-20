class Rental < ActiveRecord::Base
  belongs_to :renter, class_name: "User"
  belongs_to :bike

  def status
    today = Date.today
    if end_date < today
      "Completed"
    elsif start_date <= today && end_date >= today
      "Current"
    else
      "Upcoming"
    end
  end

  def owner
    bike.owner
  end

  # These three methods each return an array of hashes of information on a rental
  # See #to_info_hash for format of the hash

  def self.upcoming_joins(bike_params)
    rentals = joins(bike: :owner).where(bikes: bike_params).where("start_date > ?", Date.today)
    rentals.map { |rental| rental.to_info_hash }
  end

  def self.upcoming_includes(bike_params)
    rentals = includes(bike: :owner).where(bikes: bike_params).where("start_date > ?", Date.today)
    rentals.map { |rental| rental.to_info_hash }
  end

  def self.upcoming_enumeration(bike_params)
    rentals = []
    Rental.all.each do |rental|
      # Select all upcoming bikes w/ matching category & color (if color specified)
      if rental.bike.category == bike_params[:category] &&
         rental.status == "upcoming" &&
         (bike_params[:color].nil? || rental.bike.color == bike_params[:color])
        rentals << rental
      end
    end
    rentals.map { |rental| rental.to_info_hash }
  end


  def to_info_hash
    {
      start_date: self.start_date,
      end_date: self.end_date,
      bike: {
        color: self.bike.color,
        category: self.bike.category
      },
      owner_name: self.owner.name
    }
  end
end