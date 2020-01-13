# frozen_string_literal: true

module Mutations
  module ShoppingLists
    class AddShoppingListMutation < BaseMutation
      null true

      argument :people_count, Integer, required: true
      argument :recipe_id, ID, required: true

      field :shopping_list, Types::ShoppingListType, null: true
      field :errors, [String], null: false

      def resolve(people_count:, recipe_id:)
        recipe = object_from_id('recipe', recipe_id, context)
        shopping_list = ::ShoppingLists::Creator.new(recipe: recipe,
                                                     user: context[:viewer],
                                                     people_count: people_count).call

        if shopping_list.errors.blank?
          { shopping_list: shopping_list, errors: [] }
        else
          { shopping_list: nil, errors: shopping_list.errors.full_messages }
        end
      end
    end
  end
end
