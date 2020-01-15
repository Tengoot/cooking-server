# frozen_string_literal: true

module Mutations
  module Follows
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :follow,
                mutation: Mutations::Follows::AddFollowMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :remove_follow,
                mutation: Mutations::Follows::DeleteFollowMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
