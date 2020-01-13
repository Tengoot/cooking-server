# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy

  validates :archived, inclusion: { in: [true, false] }
  validates :note, length: { maximum: 512 }, allow_blank: true
  validates :people_count, presence: true, numericality: { only_integer: true,
                                                           less_than_or_equal_to: 99,
                                                           greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :shopping_list_items
end
