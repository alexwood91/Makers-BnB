require 'pg'

def persisted_data(id:)
  result = Database.query("SELECT * FROM rooms WHERE id = #{id};")
  result.first
end