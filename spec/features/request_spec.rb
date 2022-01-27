feature 'requesting rooms' do
  scenario 'being directed to the request page' do
    visit ('/rooms/new')
    fill_in('new_room', with: 'Apartment')
    fill_in('description', with: '2 beds, 1 bath')
    fill_in('price', with: '100.99')
    fill_in('datefrom', with: '2022-11-21')
    fill_in('dateto', with: '2022-12-21')
    click_button('Submit')
    visit ('/rooms')
    click_button 'Request'
    expect(page).to have_content "Please enter your dates and click request."
  end
end
