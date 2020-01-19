# frozen_string_literal: true

module Mutations
  module Recipes
    class AcceptRecipeMutation < BaseMutation
      null true

      argument :recipe_id, ID, loads: Types::RecipeType, required: true

      field :recipe, Types::RecipeType, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:accept, kwargs[:recipe])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(recipe:)
        if recipe.update(accepted: true)
          { recipe: recipe, errors: [] }
        else
          { recipe: nil, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
