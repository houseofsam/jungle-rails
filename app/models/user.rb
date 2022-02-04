class User < ActiveRecord::Base
  # validation. Ensure an email address is provided
  validates :email, uniqueness: true
  has_secure_password
end
