# frozen_string_literal: true

module Mutations
  module Recipes
    class DeleteRecipeMutation < BaseMutation
      null true

      argument :recipe_id, ID, loads: Types::RecipeType, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:delete, kwargs[:recipe])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        recipe = kwargs[:recipe]

        if recipe.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
