# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    extend Mutations::Authentication::Loader
    extend Mutations::Recipes::Loader
    extend Mutations::Ingredients::Loader
    extend Mutations::RecipeIngredients::Loader
  end
end
