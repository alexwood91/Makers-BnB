require 'pg'

class Database
  def self.connect(database_name)
    @connection = PG.connect(dbname: database_name)
  end

  class << self
    attr_reader :connection
  end

  def self.query(query, params = [])
    @connection.exec_params(query, params)
  end
end
