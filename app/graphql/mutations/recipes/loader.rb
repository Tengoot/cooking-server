# frozen_string_literal: true

module Mutations
  module Recipes
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_recipe,
                mutation: Mutations::Recipes::AddRecipeMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :edit_recipe,
                mutation: Mutations::Recipes::EditRecipeMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :delete_recipe,
                mutation: Mutations::Recipes::DeleteRecipeMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :accept_recipe,
                mutation: Mutations::Recipes::AcceptRecipeMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer] && (ctx[:viewer].mod? || ctx[:viewer].admin?) },
                mask: ->(ctx) { ctx[:viewer] && (ctx[:viewer].mod? || ctx[:viewer].admin?) }
        end
      end
    end
  end
end
