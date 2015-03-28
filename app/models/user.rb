class User < ActiveRecord::Base
  validates :email,     presence: true, uniqueness: true
  validates :password,  presence: true, length: { minimum: 8 }, confirmation: true
end
