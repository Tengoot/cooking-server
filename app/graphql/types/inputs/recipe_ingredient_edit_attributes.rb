# frozen_string_literal: true

module Types
  module Inputs
    class RecipeIngredientEditAttributes < Types::BaseInputObject
      description 'Attributes required for recipe ingredient creation on recipe'

      argument :recipe_ingredient_id, ID, loads: Types::RecipeIngredientType, required: false
      argument :amount, Integer, required: false
      argument :unit, String, required: false
      argument :ingredient_id, ID, loads: Types::IngredientType, required: false
      argument :_destroy, Boolean, required: false
    end
  end
end
