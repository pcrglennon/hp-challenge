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

  def upcoming_joins

  end

  def upcoming_includes

  end

  def upcoming_naive

  end
end