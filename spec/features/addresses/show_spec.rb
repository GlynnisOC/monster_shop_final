require 'rails_helper'

RSpec.describe "Address Show Page" do
  describe "as a registered user" do
    before :each do
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(street: "Street", city: "City", state: "Washington", zip: 98765)
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can view a specific address" do

      visit address_path(@address)

      expect(page).to have_content(@address.street)
      expect(page).to have_content(@address.city)
      expect(page).to have_content(@address.state)
      expect(page).to have_content(@address.zip)
      expect(page).to have_content(@address.nickname)
    end
  end
end
