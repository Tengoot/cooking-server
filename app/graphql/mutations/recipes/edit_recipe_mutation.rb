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
      argument :image_data_uri, String, required: false
      argument :recipe_ingredients_attributes, [Types::Inputs::RecipeIngredientEditAttributes], required: false

      field :recipe, Types::RecipeType, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:edit, kwargs[:recipe])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        recipe = kwargs[:recipe]
        attributes = kwargs.except(:recipe)
        ri_attributes = attributes[:recipe_ingredients_attributes]
        attributes[:recipe_ingredients_attributes] = ri_attributes.map(&method(:parse_recipe_ingredient)) if ri_attributes

        if recipe.update(attributes)
          { recipe: recipe, errors: [] }
        else
          { recipe: nil, errors: recipe.errors.full_messages }
        end
      end

      def parse_recipe_ingredient(attributes)
        a = attributes.to_h

        ri = a[:recipe_ingredient]
        a.merge!(id: ri.id) if ri

        i = a[:ingredient]
        a.merge!(ingredient_id: i.id) if i

        a.except(:recipe_ingredient, :ingredient)
      end
    end
  end
end
