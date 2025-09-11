class RenameReservationsToBookings < ActiveRecord::Migration[8.0]
  def change
    rename_table :reservations, :bookings
  end
end
