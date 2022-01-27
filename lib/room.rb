require 'pg'

class Room

  attr_reader :roomid, :name, :description, :price, :datefrom, :dateto

  def initialize(roomid:, name:, description:, price:, datefrom:, dateto:)
    @roomid = roomid
    @name = name
    @description = description
    @price = price
    @datefrom = datefrom
    @dateto = dateto
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map do |room|
      Room.new(roomid: room['roomid'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'])
    end
  end

  def self.create(name:, description:, price:, datefrom:, dateto:)
    result = Database.query("INSERT INTO rooms (name, description, price, datefrom, dateto) VALUES($1, $2, $3, $4, $5) RETURNING roomid, name, description, price;", [name, description, price, datefrom, dateto])
    Room.new(roomid: result[0]['roomid'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], datefrom: result[0]['datefrom'], dateto: result[0]['dateto'])
  end
end
