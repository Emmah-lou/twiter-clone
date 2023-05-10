class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 64 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 64 }
  validates :password, presence: true, length: { minimum: 8, maximum: 64 }

  has_many :tweets
  has_many :sessions


  after_validation :hash_password

  def hash_password
    self.password = BCrypt::Password.create(self.password)
  end
end
