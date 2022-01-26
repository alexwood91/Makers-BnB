require 'room'

feature 'viewing rooms' do
  scenario 'visiting the rooms page' do
    visit ('/rooms')
    expect(page).to have_content "Welcome to Makers BnB!"
  end

  scenario 'a user sees a list of rooms' do
    Database.query("INSERT INTO rooms VALUES (1, 'Apartment');")
    visit ('/rooms')
    expect(page).to have_content "Apartment"
  end
end
