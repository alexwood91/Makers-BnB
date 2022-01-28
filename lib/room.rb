require 'pg'
require './lib/database'
require './lib/user'

class Room

  attr_reader :roomid, :name, :description, :price, :datefrom, :dateto, :userid

  def initialize(roomid:, name:, description:, price:, datefrom:, dateto:, userid:)
    @roomid = roomid
    @name = name
    @description = description
    @price = price
    @datefrom = datefrom
    @dateto = dateto
    @userid = userid
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map do |room|
      Room.new(roomid: room['roomid'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'], userid: room['userid'])
    end
  end

  def self.create(name:, description:, price:, datefrom:, dateto:, userid:)
    result = Database.query("INSERT INTO rooms (name, description, price, datefrom, dateto, userid) VALUES($1, $2, $3, $4, $5, $6) RETURNING roomid, name, description, price, datefrom, dateto, userid;", [name, description, price, datefrom, dateto, userid])
    Room.new(roomid: result[0]['roomid'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], datefrom: result[0]['datefrom'], dateto: result[0]['dateto'], userid: result[0]['userid'])
  end
end
