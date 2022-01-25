require 'room'

feature 'viewing rooms' do
  scenario 'visiting the rooms page' do
    visit ('/available')
    expect(page).to have_content "Welcome to Makers BnB!"
  end

  scenario 'a user sees a list of rooms' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO rooms VALUES (1, 'Premier Inn');")
    visit ('/available')
    expect(page).to have_content "Premier Inn"
  end
end
