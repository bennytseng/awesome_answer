class Question < ApplicationRecord
  #this was added and associates the question with answer in a one to many fashion and provide handy methods to create associated answers
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy

  belongs_to :user
  has_many :users, through: :likes

  # validates(:title, {presence: true})
  validates :title, presence: true, uniqueness: {message: "must be unique!"}
  validates :body, presence: true, length: {minimum: 5}
  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  mount_uploader :image, ImageUploader

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

  def like_for(user)
    likes.find_by_user_id(user)
  end

  def vote_for(user)
    votes.find_by_user_id user
  end

  def vote_value
    votes.where(is_up: true).count - votes.where(is_up:false).count
  end



  delegate :first_name, :last_name, to: :user, prefix: true, allow_nil: true
  # #top line replaces below methods when calling json API, so above line will be user_first_name as method 
  # def user_first_name
  #   user.first_name if user
  #   # if user is needed because some users are deleted and nil. need if otherwise exception error!!
  # end
  #
  # def user_last_name
  #   user.last_name if user
  # end

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
