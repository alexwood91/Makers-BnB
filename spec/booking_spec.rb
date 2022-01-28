require 'booking'
require 'database_helpers'

describe Booking do
  it 'creates a new booking' do
    booking = Booking.create(bookfrom: '2022-10-10', bookto: '2022-10-11', approved: false, userid: @userid, roomid: @roomid)
    persisted_data = persisted_booking_data(bookingid: booking.bookingid)

    expect(booking).to be_a Booking
    expect(booking.bookingid).to eq persisted_data['bookingid']
  end
end
