require 'room'
require 'user'

feature 'viewing rooms' do
  scenario 'visiting the rooms page' do
    setup_test_user
    expect(page).to have_content "Welcome, example@example.com to Makers BnB!"
  end

  scenario 'a user sees a list of rooms' do
    Database.query("INSERT INTO rooms VALUES (1, 'Apartment');")
    setup_test_user
    expect(page).to have_content "Apartment"
  end
end
