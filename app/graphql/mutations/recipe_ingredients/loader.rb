# frozen_string_literal: true

module Mutations
  module RecipeIngredients
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::AddRecipeIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :edit_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::EditRecipeIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :delete_recipe_ingredient,
                mutation: Mutations::RecipeIngredients::DeleteRecipeIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
