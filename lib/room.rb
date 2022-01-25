require 'pg'

class Room

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
  
    result = connection.exec('SELECT * FROM rooms;')
    result.map { |room| room['name'] }
  end
end
