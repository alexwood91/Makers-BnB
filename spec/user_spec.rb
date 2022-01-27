require 'database'
require './lib/user'
require 'bcrypt'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'example@example.com', password: 'password123')

    persisted_data = Database.query('select * from users;')

    expect(user).to be_a User
    expect(user.userid).to eq persisted_data.first['userid']
    expect(user.email).to eq 'example@example.com'
  end
end

describe '.find_userid' do
  it 'finds a user by userid' do
    user = User.create(email: 'test@example.com', password: 'password123')
    result = User.find_userid(user.userid)

    expect(result.userid).to eq user.userid
    expect(result.email).to eq user.email
  end
end

describe '.find_userid' do
  it 'returns nil if there is no userid given' do
    expect(User.find_userid(nil)).to eq nil
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
      expect(signedin_user.userid).to eq user.userid
    end
  end
