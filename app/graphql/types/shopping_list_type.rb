# frozen_string_literal: true

module Types
  class ShoppingListType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :archived, Boolean, null: false
    field :note, String, null: false
    field :people_count, Integer, null: false
    field :recipe, Types::RecipeType, null: false
    field :shopping_list_items, [Types::ShoppingListItemType], null: false

    def recipe
      RecordLoader.for(Recipe).load(object.recipe_id)
    end

    def shopping_list_items
      AssociationLoader.for(ShoppingList, :shopping_list_items).load(object)
    end
  end
end
