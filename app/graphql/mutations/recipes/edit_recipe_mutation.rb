# frozen_string_literal: true

module Mutations
  module Recipes
    class EditRecipeMutation < BaseMutation
      null true

      argument :recipe_id, ID, loads: Types::RecipeType, required: true
      argument :title, String, required: false
      argument :time_to_prepare, String, required: false
      argument :short_description, String, required: false
      argument :description, String, required: false
      argument :people_count, Integer, required: false

      field :recipe, Types::RecipeType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        recipe = kwargs[:recipe]
        recipe.assign_attributes(kwargs.except(:recipe))

        if recipe.save
          { recipe: recipe, errors: [] }
        else
          { recipe: nil, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
