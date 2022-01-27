feature 'confirmed request' do
  scenario 'confirmation of request' do
    visit ('/rooms/request')
    fill_in('bookfrom', with: '2022-02-21')
    fill_in('bookto', with: '2022-02-28')
    click_button 'Request'
    expect(page).to have_content "The owner will be in contact shortly."
  end
end
