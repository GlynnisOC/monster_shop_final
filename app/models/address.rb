class Address < ApplicationRecord
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :nickname

  belongs_to :user

  enum nickname: [:home, :office, :school]
end
