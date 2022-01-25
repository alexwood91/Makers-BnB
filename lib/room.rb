require 'pg'

class Room

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    result = Database.query('SELECT * FROM rooms;')
    result.map { |room| room['name'] }
  end
end
