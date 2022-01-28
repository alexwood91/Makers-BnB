require 'pg'
require './lib/database'
require './lib/user'
require './lib/room'

class Booking

  attr_reader :bookingid, :bookfrom, :bookto, :approved, :userid, :roomid

  def initialize(bookingid:, bookfrom:, bookto:, approved:, userid:, roomid:)
    @bookingid = bookingid
    @bookfrom = bookfrom
    @bookto = bookto
    @approved = false
    @userid = userid
    @roomid = roomid
  end

  def self.create(bookfrom:, bookto:, approved:, userid:, roomid:)
    result = Database.query(
      "INSERT INTO bookings (bookfrom, bookto, approved, userid, roomid)
      VALUES($1, $2, $3, $4, $5)
      RETURNING bookingid, bookfrom, bookto, userid, roomid;",
      [bookfrom, bookto, approved, userid, roomid]
    )
    Booking.new(
      bookingid: result[0]['bookingid'],
      bookfrom: result[0]['bookfrom'],
      bookto: result[0]['bookto'],
      approved: result[0]['approved'],
      userid: result[0]['userid'],
      roomid: result[0]['roomid']
    )
  end
end
