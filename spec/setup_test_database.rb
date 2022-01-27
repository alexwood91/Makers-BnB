require 'pg'

def setup_test_database
  Database.query('TRUNCATE rooms, users;')
end
