# frozen_string_literal: true

module Mutations
  module ShoppingListItems
    class DeleteShoppingListItemMutation < BaseMutation
      null true

      argument :shopping_list_item_id, ID, loads: Types::ShoppingListItemType, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def resolve(shopping_list_item:)
        if shopping_list_item.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
