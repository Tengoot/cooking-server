# frozen_string_literal: true

module Types
  class ShoppingListItemType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :ticked, Boolean, null: false
    field :shopping_list, Types::ShoppingListType, null: false
    field :recipe_ingredient, Types::RecipeIngredientType, null: false

    def shopping_list
      RecordLoader.for(ShoppingList).load(object.shopping_list_id)
    end

    def recipe_ingredient
      RecordLoader.for(RecipeIngredient).load(object.recipe_ingredient_id)
    end
  end
end
