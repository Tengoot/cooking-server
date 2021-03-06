# frozen_string_literal: true

module Mutations
  module Recipes
    class AddRecipeMutation < BaseMutation
      null true

      argument :title, String, required: true
      argument :time_to_prepare, String, required: true
      argument :short_description, String, required: false
      argument :description, String, required: true
      argument :people_count, Integer, required: true
      argument :image_data_uri, String, required: false
      argument :recipe_ingredients_attributes, [Types::Inputs::RecipeIngredientCreateAttributes], required: false

      field :recipe, Types::RecipeType, null: true
      field :errors, [String], null: false

      def authorized?(**_kwargs)
        return true if context[:ability].can?(:create, Recipe)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        attributes = kwargs.merge(user: context[:viewer])
        ri_attributes = attributes[:recipe_ingredients_attributes]
        attributes[:recipe_ingredients_attributes] = ri_attributes.map(&:to_h) if ri_attributes
        recipe = Recipe.new(attributes)
        if recipe.save
          { recipe: recipe, errors: [] }
        else
          { recipe: nil, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
