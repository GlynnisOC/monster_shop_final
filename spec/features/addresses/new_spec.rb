require 'rails_helper'

RSpec.describe "New Address Page" do
  describe "as a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(street: "Street", city: "City", state: "Washington", zip: 98765)
      @admin = User.create!(name: 'Megan', email: 'admin@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can enter a new address and be returned to profile page" do

      visit new_address_path

      fill_in "Street", with: "Fourth Place"
      fill_in "City", with: "Selah"
      fill_in "State", with: "Washington"
      fill_in "Zip", with: 98942
      select "office", from: "Nickname"
      click_button "Add Address"
      address = Address.last

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(address.street)
      expect(page).to have_content(address.city)
      expect(page).to have_content(address.state)
      expect(page).to have_content(address.zip)
      expect(page).to have_content(address.nickname)
    end
  end
end
