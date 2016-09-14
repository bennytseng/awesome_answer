class User < ApplicationRecord
  #based on gem bcrypt
  has_secure_password
  before_create :generate_api_key

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                  uniqueness: {case_sensitive: false},
                  format:     VALID_EMAIL_REGEX


 has_many :questions, dependent: :nullify
 has_many :likes, dependent: :destroy
 # in like.rb model, there is no belongs_to liked_question thus you have to define source as question
 has_many :liked_questions, through: :likes, source: :question

 has_many :votes, dependent: :destroy
 has_many :voted_questions, through: :votes, source: :question
  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(32)
      break unless User.find_by_api_key(self.api_key)
    end
  end
end
