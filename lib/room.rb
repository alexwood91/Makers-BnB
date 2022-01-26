require 'pg'

class Room

  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map { |room| room['name'] }
    # Room.new(id: room['id'], name: room['name'])
  end

  def self.create(name:)
    result = Database.query("INSERT INTO rooms (name) VALUES ('#{name}')  RETURNING id, name;")
    Room.new(id: result[0]['id'], name: result[0]['name'])
  end
end
