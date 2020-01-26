# frozen_string_literal: true

module Types
  module Inputs
    class RecipeIngredientCreateAttributes < GraphQL::Schema::InputObject
      description 'Attributes required for recipe ingredient creation on recipe'

      argument :amount, Integer, required: true
      argument :unit, String, required: true
      argument :ingredient_id, ID, loads: Types::IngredientType, required: true
    end
  end
end
