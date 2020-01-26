# frozen_string_literal: true

module Mutations
  module Ingredients
    class EditIngredientMutation < BaseMutation
      null true

      argument :ingredient_id, ID, loads: Types::IngredientType, required: true
      argument :name, String, required: false
      argument :average_price, Float, required: false
      argument :description, String, required: false
      argument :kcal, Integer, required: false
      argument :image_data_uri, String, required: false

      field :ingredient, Types::IngredientType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        ingredient = kwargs[:ingredient]
        ingredient.assign_attributes(kwargs.except(:ingredient))

        if ingredient.save
          { ingredient: ingredient, errors: [] }
        else
          { ingredient: nil, errors: ingredient.errors.full_messages }
        end
      end
    end
  end
end
