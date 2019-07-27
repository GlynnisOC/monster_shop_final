require 'rails_helper'

RSpec.describe 'new user registration' do
  describe 'as a visitor' do
    it "has me add my address when registering and it's my default address" do
      name = "Kirren"
      email = "kikilou@gmail.com"
      street = "123 Goat St."
      city = "Nashville"
      state = "Tennessee"
      zip = 98765
      password = "password"

      visit new_user_path

      fill_in "Name", with: name
      fill_in "Email", with: email
      fill_in "Street", with: street
      fill_in "City", with: city
      fill_in "State", with: state
      fill_in "Zip", with: zip
      fill_in :password, with: password
      fill_in :password_confirmation, with: password
      click_button "Register"

      user = User.last

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{user.name}!")
    end
  end
end
