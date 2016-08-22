class Question < ApplicationRecord
  #this was added and associates the question with answer in a one to many fashion and provide handy methods to create associated answers
  has_many :answers, dependent: :destroy

  # validates(:title, {presence: true})
  validates :title, presence: true, uniqueness: {message: "must be unique!"}
  validates :body, presence: true, length: {minimum: 5}

  # This validatse that the title/body combination is unique which means that
  # title doesn't have to be unique by itself, body doesn't have to be unique
  # by itself but the combination of the two must be unique.
  # validates :body, uniqueness: {scope: :title}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  # this defines a custom validation. It takes a first argument which in this
  # case is a private method
  validate :no_monkey

  # after_initialize :set_defaults

  before_validation :capitalize_title

  def titleized_title
    title.titleize
  end

  # scope :recent_ten, lambda { order(created_at: :desc).limit(10) }
  def self.recent_ten
    order(created_at: :desc).limit(10)
  end
# searches keyword wildcard in title and body. be mindful of array syntax
  def self.search(keyword)
    where(["title ILIKE ? OR body ILIKE ?", "%#{keyword}%", "%#{keyword}%"])
  end

  private
# conditional is needed to check that title exists and not null, otherwise error will occur when trying to capitalize
  def capitalize_title
    self.title.capitalize! if title
  end

  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please!")
    end
  end

  # def set_defaults
  #   self.view_count ||= 0
  # end

end
