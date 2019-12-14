# frozen_string_literal: true

class Recipe < ApplicationRecord
  include Shrine::Attachment(:image)

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, :time_to_prepare,
            presence: true, length: { maximum: 256 }
  validates :short_description, length: { maximum: 512 }, allow_blank: true
  validates :description, presence: true, length: { maximum: 16_384 }
  validates :people_count, presence: true, numericality: { only_integer: true,
                                                           less_than_or_equal_to: 99,
                                                           greater_than_or_equal_to: 0 }
end