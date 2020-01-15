# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    extend Mutations::Authentication::Loader
    extend Mutations::Recipes::Loader
    extend Mutations::Ingredients::Loader
    extend Mutations::RecipeIngredients::Loader
    extend Mutations::ShoppingLists::Loader
    extend Mutations::ShoppingListItems::Loader
    extend Mutations::Favorites::Loader
    extend Mutations::Follows::Loader
    extend Mutations::Comments::Loader
  end
end
