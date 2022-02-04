class User < ActiveRecord::Base
  # validation. Ensure an email address doesn't exist in DB
  validates :email, uniqueness: true
  has_secure_password
end
