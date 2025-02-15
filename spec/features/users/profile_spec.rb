require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(street: "Street", city: "City", state: "Washington", zip: 98765)
      @admin = User.create!(name: 'Megan', email: 'admin@example.com', password: 'securepassword')
    end

    it "I can view my profile page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.email)
      expect(page).to have_content(@address.street)
      expect(page).to have_content("#{@address.city}")
      expect(page).to have_content("#{@address.state}")
      expect(page).to have_content("#{@address.zip}")
      expect(page).to_not have_content(@user.password)
      expect(page).to have_link('Edit')
    end

    it "I can update my profile data" do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      click_link 'Edit'

      expect(current_path).to eq('/profile/edit')

      name = 'New Name'
      email = 'new@example.com'

      fill_in "Name", with: name
      fill_in "Email", with: email
      click_button 'Update Profile'

      expect(current_path).to eq(profile_path)

      expect(page).to have_content('Profile has been updated!')
      expect(page).to have_content(name)
      expect(page).to have_content(email)
    end

    it "I can update my password" do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      click_link 'Change Password'

      expect(current_path).to eq('/profile/edit_password')

      password = "newpassword"

      fill_in "Password", with: password
      fill_in "Password confirmation", with: password
      click_button 'Change Password'

      expect(current_path).to eq(profile_path)

      expect(page).to have_content('Profile has been updated!')

      click_link 'Log Out'

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      expect(page).to have_content("Your email or password was incorrect!")

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: "newpassword"
      click_button 'Log In'

      expect(current_path).to eq(profile_path)
    end

    it "I must use a unique email address" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/profile/edit'

      fill_in "Email", with: @admin.email
      click_button "Update Profile"

      expect(page).to have_content("email: [\"has already been taken\"]")
      expect(page).to have_button "Update Profile"
    end

    it "I can edit my addresses" do
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path

      within "#address-#{@addr_2.id}" do
        click_button "Edit Address"
        expect(current_path).to eq(edit_address_path(@addr_2))
      end
    end

    it "I can create a new address" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path

      click_button "Enter New Address"
      expect(current_path).to eq(new_address_path)
    end

    it "I can delete an address" do
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654)

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@addr_2.id}" do
        click_button "Delete Address"
      end

      @addresses = Address.all
      @addresses.reload

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_content(@addr_2.state)
    end

    it "I can look at a specific address" do
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path

      within "#address-#{@addr_3.id}" do
        click_button "View"
        expect(current_path).to eq(address_path(@addr_3))
      end
    end
  end
end
