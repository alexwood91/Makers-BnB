feature 'user login' do
  scenario 'user logs in via form' do
    User.create(email: "example@example.com", password: "Seekrit")
    visit('/sign-in')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'Seekrit')
    click_button('Sign In')

    expect(page).to have_content 'You are signed-in, example@example.com'
    expect(page).to have_no_content 'Incorrect password'
  end
  scenario 'user enters wrong password when signing in' do
    User.create(email: "example@example.com", password: "Seekrit")

    visit('/sign-in')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'wrongpassword')
    click_button('Sign In')

    expect(page).to have_content 'Incorrect password'
    expect(page).to have_no_content 'You are signed-in, example@example.com'
  end


end
