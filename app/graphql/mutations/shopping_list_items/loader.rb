# frozen_string_literal: true

module Mutations
  module ShoppingListItems
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :delete_shopping_list_item,
                mutation: Mutations::ShoppingListItems::DeleteShoppingListItemMutation
          field :toggle_shopping_list_item,
                mutation: Mutations::ShoppingListItems::ToggleShoppingListItemMutation
        end
      end
    end
  end
end
