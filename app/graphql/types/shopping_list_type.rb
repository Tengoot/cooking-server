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
    field :percent_done, Integer, null: true
    field :created_at, String, null: false

    def recipe
      RecordLoader.for(Recipe).load(object.recipe_id)
    end

    def shopping_list_items
      AssociationLoader.for(ShoppingList, :shopping_list_items).load(object)
    end

    def percent_done
      items = object.shopping_list_items
      return 0 if items.size.zero?

      ticked = items.select(&:ticked)

      ((ticked.size / items.size.to_f) * 100).to_i
    end
  end
end
