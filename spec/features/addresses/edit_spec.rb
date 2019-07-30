require 'rails_helper'

RSpec.describe "Edit Address Page" do
  describe "as a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(street: "Street", city: "City", state: "Washington", zip: 98765)
      @admin = User.create!(name: 'Megan', email: 'admin@example.com', password: 'securepassword')
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567, nickname: 1)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654, nickname: 2)
    end

    it "can edit my address and be returned to profile page" do

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@addr_3.id}" do
        click_button "Edit Address"
      end

      fill_in "Street", with: "Fourth Place"
      fill_in "City", with: "Selah"
      fill_in "State", with: "Washington"
      fill_in "Zip", with: 98942
      select "office", from: "Nickname"
      click_button "Save Changes"

      expect(current_path).to eq(profile_path)

      within "#address-#{@addr_3.id}" do
        expect(@addr_3.reload.street).to eq("Fourth Place")
        expect(@addr_3.reload.city).to eq("Selah")
        expect(@addr_3.reload.state).to eq("Washington")
      end
    end
  end
end
