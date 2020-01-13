# frozen_string_literal: true

module Mutations
  module ShoppingLists
    class EditShoppingListMutation < BaseMutation
      null true

      argument :shopping_list_id, ID, loads: Types::ShoppingListType, required: true
      argument :people_count, Integer, required: false
      argument :archived, Boolean, required: false
      argument :note, String, required: false

      field :shopping_list, Types::ShoppingListType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        shopping_list = kwargs[:shopping_list]
        shopping_list.assign_attributes(kwargs.except(:shopping_list))

        if shopping_list.save
          { shopping_list: shopping_list, errors: [] }
        else
          { shopping_list: nil, errors: shopping_list.errors.full_messages }
        end
      end
    end
  end
end
