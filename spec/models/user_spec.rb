require 'rails_helper'

RSpec.describe User do
  describe 'Relationships' do
    it {should belong_to(:merchant).optional}
    it {should have_many :orders}
    it {should have_many :addresses}
    it {should accept_nested_attributes_for :addresses}
  end

  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end
end
