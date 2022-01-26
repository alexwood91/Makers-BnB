require 'room'
require 'database_helpers'

describe Room do

  describe '.all' do
    it 'returns a full list of rooms' do
      room1 = Room.create(name: 'Apartment', description: '2 beds, 1 bath', price: '100.99' )
      room2 = Room.create(name: 'House', description: '3 beds, 3 bath', price: '200.99' )
      room3 = Room.create(name: 'Flat', description: '1 bed, 1 bath', price: '50.99' )

      rooms = Room.all
      expect(rooms.length).to eq 3
      expect(rooms.first).to be_a Room
      expect(rooms.first.id).to eq room1.id
      expect(rooms.first.name).to eq 'Apartment'
      expect(rooms.first.description).to eq '2 beds, 1 bath'
      expect(rooms.first.price).to eq '100.99'
    end
  end


  describe '.create' do
    it 'creates a new room' do
      room = Room.create(name: 'Apartment', description: '2 beds, 1 bath', price: '100.99' )
      persisted_data = persisted_data(id: room.id)

      expect(room).to be_a Room
      expect(room.id).to eq persisted_data['id']
      expect(room.name).to eq 'Apartment'
    end
  end  
end
