class Address < ApplicationRecord
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :nickname

  belongs_to :user
  has_many :orders

  enum nickname: [:home, :office, :school]

  def shipped_to?
    shipped_orders = orders.where(status: 2)
    if shipped_orders.length > 0
      true
    end
  end
end
