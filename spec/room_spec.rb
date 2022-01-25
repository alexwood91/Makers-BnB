require 'room'

describe Room do
  it 'has a name' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO rooms (name) VALUES ('Premier Inn');")
    rooms = Room.all
    expect(rooms).to include("Premier Inn")
  end
end
