# frozen_string_literal: true

module Mutations
  module Favorites
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :favorite,
                mutation: Mutations::Favorites::AddFavoriteMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :remove_favorite,
                mutation: Mutations::Favorites::DeleteFavoriteMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
