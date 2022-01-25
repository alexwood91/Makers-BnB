require 'room'

describe Room do
  it 'has a name' do
    room = Room.new("premier inn")
    expect(room.name).to eq "premier inn"
  end


end