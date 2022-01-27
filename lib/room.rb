require 'pg'

class Room

  attr_reader :id, :name, :description, :price, :datefrom, :dateto

  def initialize(id:, name:, description:, price:, datefrom:, dateto:)
    @id = id
    @name = name
    @description = description
    @price = price
    @datefrom = datefrom
    @dateto = dateto
    
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map do |room|
      Room.new(id: room['id'], name: room['name'], description: room['description'], price: room['price'], datefrom: room['datefrom'], dateto: room['dateto'])
    end
  end

  def self.create(name:, description:, price:, datefrom:, dateto:)
    result = Database.query("INSERT INTO rooms (name, description, price, datefrom, dateto) VALUES($1, $2, $3, $4, $5) RETURNING id, name, description, price;", [name, description, price, datefrom, dateto])
    Room.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], datefrom: result[0]['datefrom'], dateto: result[0]['dateto'])
  end
  
  def self.delete(id:)
    result = Database.query("delete from rooms where id = $1 RETURNING id, name, description, price;", [id])
    Room.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], datefrom: result[0]['datefrom'], dateto: result[0]['dateto'])
  end

end
