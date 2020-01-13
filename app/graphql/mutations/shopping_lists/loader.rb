# frozen_string_literal: true

module Mutations
  module ShoppingLists
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_shopping_list,
                mutation: Mutations::ShoppingLists::AddShoppingListMutation
          field :delete_shopping_list,
                mutation: Mutations::ShoppingLists::DeleteShoppingListMutation
          field :edit_shopping_list,
                mutation: Mutations::ShoppingLists::EditShoppingListMutation
        end
      end
    end
  end
end
