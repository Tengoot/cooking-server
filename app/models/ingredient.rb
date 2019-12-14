# frozen_string_literal: true

class Ingredient < ApplicationRecord
  include Shrine::Attachment(:image)

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: { maximum: 256 }
  validates :description, allow_blank: true, length: { maximum: 16_384 }
  validates :kcal, allow_nil: true, numericality: { only_integer: true }
end
