require 'pg'

def setup_test_database
  p "Setting up test database..."
  Database.query("TRUNCATE rooms, users;")
end
