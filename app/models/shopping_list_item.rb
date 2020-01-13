# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :recipe_ingredient

  validates :ticked, inclusion: { in: [true, false] }
end
