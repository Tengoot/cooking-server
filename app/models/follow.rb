# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :user

  validates :user_id, uniqueness: { scope: :follower_id }
end
