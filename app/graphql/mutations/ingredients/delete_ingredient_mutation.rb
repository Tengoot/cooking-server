# frozen_string_literal: true

module Mutations
  module Ingredients
    class DeleteIngredientMutation < BaseMutation
      null true

      argument :ingredient_id, ID, loads: Types::IngredientType, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        ingredient = kwargs[:ingredient]

        if ingredient.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: ingredient.errors.full_messages }
        end
      end
    end
  end
end
