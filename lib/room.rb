require 'pg'

class Room

  attr_reader :id, :name, :description, :price

  def initialize(id:, name:, description:, price:)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map do |room|
      Room.new(id: room['id'], name: room['name'], description: room['description'], price: room['price'])
    end
  end

  def self.create(name:, description:, price:)
    result = Database.query("INSERT INTO rooms (name, description, price) VALUES('#{name}', '#{description}', '#{price}')  RETURNING id, name, description, price;")
    Room.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'])
  end
end
