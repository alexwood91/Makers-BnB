def setup_test_user
  User.create(email: "example@example.com", password: "Seekrit")
  visit('/sessions/new')
  fill_in('email', with: 'example@example.com')
  fill_in('password', with: 'Seekrit')
  click_button('Sign In')
end
