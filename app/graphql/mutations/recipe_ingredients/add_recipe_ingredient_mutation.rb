# frozen_string_literal: true

module Mutations
  module RecipeIngredients
    class AddRecipeIngredientMutation < BaseMutation
      null true

      argument :recipe_id, ID, required: true, loads: Types::RecipeType
      argument :ingredient_id, ID, required: true, loads: Types::IngredientType
      argument :amount, Integer, required: false
      argument :unit, String, required: false

      field :recipe_ingredient, Types::RecipeIngredientType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        recipe_ingredient = RecipeIngredient.new(kwargs)
        if recipe_ingredient.save
          { recipe_ingredient: recipe_ingredient, errors: [] }
        else
          { recipe_ingredient: nil, errors: recipe_ingredient.errors.full_messages }
        end
      end
    end
  end
end
