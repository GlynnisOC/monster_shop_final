require 'rails_helper'

RSpec.describe Address do
  describe 'validations' do
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :nickname }
  end

  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many :orders }
  end

  describe 'nicknames' do
    it "saves the first address as default" do
      user = User.create!(name: "Kirren", email: "yooo@email.com", password: "password")
      address = user.addresses.create!(street: "Street", city: "city", state: "state", zip: 98765)
      addy_2 = user.addresses.create!(street: "Fivestar", city: "Nashyville", state: "Tennessee", zip: 12345, nickname: 1)

      expect(address.nickname).to eq("home")
      expect(addy_2.nickname).to eq("office")
      expect(user.addresses).to eq([address, addy_2])
    end
  end

  describe 'instance method' do
    it ".shipped_to?" do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      user = User.create!(name: "Kirren", email: "yooo@email.com", password: "password")
      address = user.addresses.create!(street: "Street", city: "city", state: "state", zip: 98765)
      addy_2 = user.addresses.create!(street: "Fivestar", city: "Nashyville", state: "Tennessee", zip: 12345, nickname: 1)
      @order_1 = user.orders.create!(address_id: address.id, status: "pending")
      @order_2 = user.orders.create!(address_id: addy_2.id, status: "shipped")

      expect(addy_2.shipped_to?).to be_truthy
      expect(address.shipped_to?).to be_falsy
    end
  end
end
