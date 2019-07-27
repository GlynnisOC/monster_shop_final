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
end
