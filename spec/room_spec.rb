require 'room'
require 'database_helpers'

describe Room do
  it 'has a name' do
    Database.query("INSERT INTO rooms (name) VALUES ('Premier Inn');")
    rooms = Room.all
    expect(rooms).to include("Premier Inn")
  end

  describe '.create' do
    it 'creates a new room' do
      room = Room.create(name: 'Premier Inn')
      persisted_data = persisted_data(id: room.id)

      expect(room).to be_a Room
      expect(room.id).to eq persisted_data['id']
      expect(room.name).to eq 'Premier Inn'
    end
  end  
end
