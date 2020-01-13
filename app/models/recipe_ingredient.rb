# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :amount, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :unit, allow_blank: true, length: { maximum: 256 }
  validates :ingredient_id, uniqueness: { scope: :recipe_id }
end
