require 'pg'

def persisted_room_data(roomid:)
  result = Database.query("SELECT * FROM rooms WHERE roomid = $1;", [roomid])
  result.first
end

def persisted_booking_data(bookingid:)
  result = Database.query("SELECT * FROM bookings WHERE bookingid = $1;", [bookingid])
  result.first
end