# frozen_string_literal: true

module Mutations
  module Ingredients
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_ingredient,
                mutation: Mutations::Ingredients::AddIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :edit_ingredient,
                mutation: Mutations::Ingredients::EditIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :delete_ingredient,
                mutation: Mutations::Ingredients::DeleteIngredientMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
