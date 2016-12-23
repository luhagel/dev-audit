class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 20}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 6, maximum: 100}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_many :teams

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end

def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
end