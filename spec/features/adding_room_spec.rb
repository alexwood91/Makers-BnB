feature 'adding a new room' do
  scenario 'A user can add a room to the list' do
    visit ('/new')
    fill_in('new_room', with: 'Apartment')
    click_button('Submit')
    expect(page).to have_content('Apartment')
  end
end