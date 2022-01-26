feature 'Register' do
  scenario 'User registers via the form' do
    visit('/users/new')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'Seekrit')
    fill_in('password_confirm', with: 'Seekrit')
    click_button('save')

    expect(page).to have_content 'Thank you for registering - please log in'
  end
end
