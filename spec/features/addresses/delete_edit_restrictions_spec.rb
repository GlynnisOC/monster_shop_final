require 'rails_helper'

RSpec.describe "User Profile Path" do
  describe "As a registered user" do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @nessie = @brian.items.create!(name: 'Nessie', description: "I'm a Loch Monster!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: false, inventory: 3 )
      @user = User.create!(name: 'Megan', email: 'megan@example.com', password: 'securepassword')
      @address = @user.addresses.create!(street: "Street", city: "City", state: "Washington", zip: 98765)
      @addr_2 = @user.addresses.create!(street: "Street TWO", city: "Citytwo", state: "Missouri", zip: 43567)
      @addr_3 = @user.addresses.create!(street: "Threet", city: "Walla Walla", state: "Cali", zip: 87654)
      @order_1 = @user.orders.create!(address_id: @address.id, status: 2)
      @order_2 = @user.orders.create!(address_id: @addr_2.id)
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)
      @order_1.order_items.create!(item: @hippo, price: @hippo.price, quantity: 3)
      @order_2.order_items.create!(item: @hippo, price: @hippo.price, quantity: 5)
    end

    it "I cannot delete an address that has been shipped to" do

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@address.id}" do
        expect(page).to_not have_button "Delete Address"
      end
    end

    it "I cannot edit an address that has been shipped to" do

      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      within "#address-#{@address.id}" do
        expect(page).to_not have_button "Edit Address"
      end
    end
  end
end
