require 'pg'
require './lib/database'
require './lib/user'
require './lib/room'

class Booking

  attr_reader :bookingid, :name, :bookfrom, :bookto, :approved, :userid, :roomid

  def initialize(bookingid:, name:, bookfrom:, bookto:, approved:, userid:, roomid:)
    @bookingid = bookingid
    @name = name
    @bookfrom = bookfrom
    @bookto = bookto
    @approved = false
    @userid = userid
    @roomid = roomid
  end

  def self.create(name:, bookfrom:, bookto:, approved:, userid:, roomid:)
    result = Database.query("INSERT INTO bookings (name, bookfrom, bookto, approved, userid, roomid) VALUES($1, $2, $3, $4, $5, $6) RETURNING bookingid, name, bookfrom, bookto, userid, roomid;", [name, bookfrom, bookto, approved, userid, roomid])
    Booking.new(bookingid: result[0]['bookingid'], name: result[0]['name'], bookfrom: result[0]['bookfrom'], bookto: result[0]['bookto'], approved: result[0]['approved'], userid: result[0]['userid'], roomid: result[0]['roomid'])
  end
end