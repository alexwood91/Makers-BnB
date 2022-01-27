feature 'manage' do
  scenario 'it lists all my rooms' do
   visit '/rooms/manage'
   expect(page).to have_content '' 
 