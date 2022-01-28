feature 'requesting rooms' do
  scenario 'being directed to the request page' do
    setup_test_user
    visit ('/rooms/new')
    fill_in('new_room', with: 'Apartment')
    fill_in('description', with: '2 beds, 1 bath')
    fill_in('price', with: '100.99')
    fill_in('datefrom', with: '2022-02-01')
    fill_in('dateto', with: '2022-02-21')
    click_button('Submit')
    visit ('/rooms')
    fill_in('bookfrom', with: '2022-02-01')
    fill_in('bookto', with: '2022-02-07')
    click_button 'Search'
    click_button 'Request'
    expect(page).to have_content "The owner will be in contact shortly."
    expect(page).to have_content "From 2022-02-01 to 2022-02-07"
  end
end
