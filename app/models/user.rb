# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:avatar)

  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x.freeze

  has_many :shopping_lists, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :users, through: :follows
  has_many :observations, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :observations
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nick, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                                                message: 'has wrong format' }
  validates :password, length: { in: 8..40 },
                       format: { with: PASSWORD_FORMAT, message: 'is too weak' },
                       if: ->{ password.present? }
  validates :admin, :mod, inclusion: { in: [true, false] }
  validates :forgot_password_token, uniqueness: true, allow_nil: true

  def generate_password_token!
    update!(
      forgot_password_token: generate_token,
      forgot_password_sent_at: Time.current
    )
  end

  def password_token_valid?
    (forgot_password_sent_at + 24.hours) > Time.current
  end

  def reset_password!(password)
    update!(
      forgot_password_token: nil,
      forgot_password_sent_at: nil,
      password: password
    )
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
