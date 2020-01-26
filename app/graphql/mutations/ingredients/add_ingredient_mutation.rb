# frozen_string_literal: true

module Mutations
  module Ingredients
    class AddIngredientMutation < BaseMutation
      null true

      argument :name, String, required: true
      argument :average_price, Float, required: false
      argument :description, String, required: false
      argument :kcal, Integer, required: false
      argument :image_data_uri, String, required: false

      field :ingredient, Types::IngredientType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        ingredient = Ingredient.new(kwargs)
        if ingredient.save
          { ingredient: ingredient, errors: [] }
        else
          { ingredient: nil, errors: ingredient.errors.full_messages }
        end
      end
    end
  end
end
