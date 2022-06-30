class User < ApplicationRecord
  # downcase entered email before save to database
  before_save { self.email = email.downcase }

  # add one to many association for user-articles
  has_many :articles
  
  # constraint for usename length and uniqueness
  validates :username, presence: true,
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 40 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # constraint for user's email length and uniqueness
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password
end