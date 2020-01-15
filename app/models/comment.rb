# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :text, allow_blank: true, length: { maximum: 16_384 }
  validates :rating, allow_nil: true, inclusion: { in: 1..5 }
  validates :recipe_id, uniqueness: { scope: :user_id }
  validate :text_or_rating

  private

  def text_or_rating
    errors.add(:base, 'invalid') unless rating || text
  end
end
