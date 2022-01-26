require 'database'
require './lib/user'
require 'bcrypt'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'example@example.com', password: 'password123')

    persisted_data = Database.query('select * from users;')

    expect(user).to be_a User
    expect(user.id).to eq persisted_data.first['id']
    expect(user.email).to eq 'example@example.com'
  end
end

describe '.find_id' do
  it 'finds a user by ID' do
    user = User.create(email: 'test@example.com', password: 'password123')
    result = User.find_id(user.id)

    expect(result.id).to eq user.id
    expect(result.email).to eq user.email
  end
end

describe '.find_id' do
  it 'returns nil if there is no ID given' do
    expect(User.find_id(nil)).to eq nil
  end
end

describe '.create' do
  it 'hashes the password using BCrypt' do
    expect(BCrypt::Password).to receive(:create).with('password123').and_return("encrypted_password")
    User.create(email: 'test@example.com', password: 'password123')
  end
end

  describe 'signin' do
    it 'returns a user given a correct email and password' do
      user = User.create(email: 'test@example.com', password: 'password123')
      signedin_user = User.signin(email: 'test@example.com', password: 'password123')
      expect(signedin_user.id).to eq user.id
    end
  end
