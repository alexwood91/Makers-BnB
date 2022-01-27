feature 'requesting rooms' do
  scenario 'being directed to the request page' do
    visit ('/rooms')
    click_button 'submit'
    expect(page).to have_content "Please enter your dates and click request."
  end
end
