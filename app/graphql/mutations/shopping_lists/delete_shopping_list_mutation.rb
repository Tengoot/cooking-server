# frozen_string_literal: true

module Mutations
  module ShoppingLists
    class DeleteShoppingListMutation < BaseMutation
      null true

      argument :shopping_list_id, ID, loads: Types::ShoppingListType, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:destroy, kwargs[:shopping_list])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(shopping_list:)
        if shopping_list.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: shopping_list.errors.full_messages }
        end
      end
    end
  end
end
