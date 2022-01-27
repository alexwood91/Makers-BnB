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

  def self.find(params)
    return nil if params.empty?

    kv_pairs = params.to_a
    columns = kv_pairs.map.with_index(1) { |pair, index| "#{pair[0]}=$#{index}" }.join(', ')
    values = kv_pairs.map { |pair| pair[1] }

    result = Database.query("SELECT * FROM users WHERE #{columns};", values)
    result.map { |row| User.new(id: row['id'], email: row['email'], password: row['pass']) }
  end

  def self.find_id(id)
    find(id: id).first
  end

  def self.signin(email:, password:)
    user = find(email: email).first
    return nil unless user && BCrypt::Password.new(user.password) == password

    user
  end
end
