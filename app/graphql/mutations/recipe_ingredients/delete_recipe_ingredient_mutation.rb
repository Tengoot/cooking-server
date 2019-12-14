# frozen_string_literal: true

module Mutations
  module RecipeIngredients
    class DeleteRecipeIngredientMutation < BaseMutation
      null true

      argument :recipe_ingredient_id, ID, required: true, loads: Types::RecipeIngredientType
      field :success, Boolean, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        recipe_ingredient = kwargs[:recipe_ingredient]

        if recipe_ingredient.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: recipe_ingredient.errors.full_messages }
        end
      end
    end
  end
end
