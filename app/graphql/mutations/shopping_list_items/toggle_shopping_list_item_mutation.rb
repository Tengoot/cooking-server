# frozen_string_literal: true

module Mutations
  module ShoppingListItems
    class ToggleShoppingListItemMutation < BaseMutation
      null true

      argument :shopping_list_item_id, ID, loads: Types::ShoppingListItemType, required: true

      field :shopping_list_item, Types::ShoppingListItemType, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:edit, kwargs[:shopping_list_item])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(shopping_list_item:)
        shopping_list_item.assign_attributes(ticked: !shopping_list_item.ticked)
        if shopping_list_item.save
          { shopping_list_item: shopping_list_item, errors: [] }
        else
          { shopping_list_item: nil, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
