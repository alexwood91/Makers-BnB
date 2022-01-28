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

  def self.available(bookfrom, bookto)
    result = Database.query("SELECT * FROM rooms WHERE datefrom <= $1 and dateto >= $2;", [bookfrom, bookto])   
    result.map do |room|
    Room.new(roomid: room['roomid'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'], userid: room['userid'])
    end
  end

  def self.find(roomid)
    result = Database.query("SELECT * FROM rooms WHERE roomid = $1;", [roomid])
    rooms = result.map do |room|
      Room.new(roomid: room['roomid'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'], userid: room['userid'])
    end
    rooms.first
  end
  
  def self.delete(id:)
    result = Database.query("delete from rooms where roomid = $1 RETURNING roomid, name, description, price, datefrom, dateto, userid;", [id])
    Room.new(roomid: result[0]['roomid'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], datefrom: result[0]['datefrom'], dateto: result[0]['dateto'], userid: result[0]['userid'])
  end
  
  def self.find_mine(userid:)
    result = Database.query("select * from rooms where rooms.userid = $1;", [userid])
    result.map do |room|
      Room.new(roomid: room['roomid'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'], userid: room['userid'])
    end 
  end
end
