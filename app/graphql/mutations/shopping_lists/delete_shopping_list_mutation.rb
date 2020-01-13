# frozen_string_literal: true

module Mutations
  module ShoppingLists
    class DeleteShoppingListMutation < BaseMutation
      null true

      argument :shopping_list_id, ID, loads: Types::ShoppingListType, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def resolve(shopping_list:)
        if shopping_list.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: recipe.errors.full_messages }
        end
      end
    end
  end
end
