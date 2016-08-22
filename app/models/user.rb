class User < ApplicationRecord
  #based on gem bcrypt
  has_secure_password
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                  uniqueness: {case_sensitive: false},
                  format:     VALID_EMAIL_REGEX

 has_many :questions, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end
end
