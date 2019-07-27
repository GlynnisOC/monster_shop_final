class User < ApplicationRecord
  has_secure_password

  belongs_to :merchant, optional: true
  has_many :orders
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  validates_presence_of :email
  validates_uniqueness_of :email

  enum role: ['default', 'merchant_admin', 'admin']
end
