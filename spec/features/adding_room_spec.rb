feature 'adding a new room' do
  scenario 'A user can add a room to the list' do
    visit ('/new')
    fill_in('new_room', with: 'Apartment')
    fill_in('description', with: '2 beds, 1 bath')
    fill_in('price', with: '100.99')
    fill_in('datefrom', with: '2022-11-21')
    fill_in('dateto', with: '2022-12-21')
    click_button('Submit')
    expect(page).to have_content('Apartment')
    expect(page).to have_content('2 beds, 1 bath')
    expect(page).to have_content('100.99')
  end
end