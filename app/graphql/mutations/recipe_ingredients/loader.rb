# frozen_string_literal: true

module Mutations
  module RecipeIngredients
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::AddRecipeIngredientMutation
          field :edit_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::EditRecipeIngredientMutation
          field :delete_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::DeleteRecipeIngredientMutation
        end
      end
    end
  end
end
