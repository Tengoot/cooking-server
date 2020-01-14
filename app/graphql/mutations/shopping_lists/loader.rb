# frozen_string_literal: true

module Mutations
  module ShoppingLists
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_shopping_list,
                mutation: Mutations::ShoppingLists::AddShoppingListMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }

          field :delete_shopping_list,
                mutation: Mutations::ShoppingLists::DeleteShoppingListMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }

          field :edit_shopping_list,
                mutation: Mutations::ShoppingLists::EditShoppingListMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
