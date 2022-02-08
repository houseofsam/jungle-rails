class User < ActiveRecord::Base
  # validation. Ensure an email address doesn't exist in DB
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :password, length: { minimum: 6 }
 	validates :password_confirmation, presence: true

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.where('email = ?', email.strip.downcase).first
    
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
