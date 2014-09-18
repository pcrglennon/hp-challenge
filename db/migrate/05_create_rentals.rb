class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.belongs_to :renter
      t.belongs_to :bike
      t.date       :end_date
      t.date       :start_date
      t.timestamps
    end
  end
end