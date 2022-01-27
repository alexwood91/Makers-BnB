require 'pg'

def persisted_data(roomid:)
  result = Database.query("SELECT * FROM rooms WHERE roomid = $1;", [roomid])
  result.first
end