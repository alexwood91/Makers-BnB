require './lib/database'
require 'bcrypt'

class User
   
  attr_reader :id, :email, :password

  def initialize(id:, email:, password:)
    @id = id
    @email = email
    @password = password
  end

  def self.create(email:, password:)
    
     encrypted_password = BCrypt::Password.create(password)
    
    result = Database.query(
      "INSERT INTO users (email, pass) VALUES($1, $2) RETURNING id, email, pass;",
      [email, encrypted_password]
    )
    User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['pass'])
  end
 
  def self.find(id)
    return nil unless id
    result = Database.query("select id, email, pass from users where id = $1;", [id])
    User.new(id: result[0]['id'], email: result[0]['email'], password: result[0]['pass'])
  end
 
end

