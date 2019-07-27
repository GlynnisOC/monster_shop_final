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
end
