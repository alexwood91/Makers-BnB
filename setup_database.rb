require_relative 'lib/database'

database_name = 'makersbnb'
database_name = 'makersbnb_test' if ENV['ENVIRONMENT'] == 'test'
Database.connect(database_name)
