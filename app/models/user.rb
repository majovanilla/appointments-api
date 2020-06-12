class User < ApplicationRecord
  has_secure_password
  has_many :appointments

  validates_presence_of :name, :password_digest
  validates :email, presence: true, uniqueness: true
end
