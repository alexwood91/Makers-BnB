feature 'User registration' do
  scenario 'User registers successfully via the form' do
    visit('/users/new')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'Seekrit1')
    fill_in('password_confirm', with: 'Seekrit1')
    click_button('save')

    expect(page).to have_content 'Thank you for registering - please log in'
  end
  scenario 'User password confirmation does not match' do
    visit('/users/new')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'Seekrit1')
    fill_in('password_confirm', with: 'Secret2')
    click_button('save')

    expect(page).to have_content 'Passwords do not match'
  end
  scenario 'User enters blank email address' do
    visit('/users/new')
    fill_in('email', with: '')
    fill_in('password', with: 'Seekrit1')
    fill_in('password_confirm', with: 'Seekrit1')
    click_button('save')

    expect(page).to have_content 'You must enter an email address'
  end
  scenario 'User enters short password' do
    visit('/users/new')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'pass')
    fill_in('password_confirm', with: 'pass')
    click_button('save')

    expect(page).to have_content 'Password too short - 8 character minimum'
  end
end
