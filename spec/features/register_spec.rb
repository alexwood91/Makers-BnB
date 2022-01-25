feature "Register" do

  scenario "User registers via the form" do

    visit('/register')
    fill_in('email', with: 'example@example.com')
    fill_in('password', with: 'Seekrit')
    fill_in('password_confirm', with: 'Seekrit')
    click_button('save')

    expect(page).to have_content "You've registered successfully"
  end

end