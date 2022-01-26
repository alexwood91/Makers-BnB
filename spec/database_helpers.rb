require 'pg'

def persisted_data(id:)
  result = Database.query("SELECT * FROM rooms WHERE id = $1;", [id])
  result.first
end