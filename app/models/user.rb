# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x.freeze

  has_many :shopping_lists, dependent: :destroy

  validates :nick, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                                                message: 'has wrong format' }
  validates :password, length: { in: 8..40 },
                       format: { with: PASSWORD_FORMAT, message: 'is too weak' },
                       if: ->{ password.present? }
end
