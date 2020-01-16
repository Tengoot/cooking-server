# frozen_string_literal: true

module Mutations
  module Users
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :edit_user,
                mutation: Mutations::Users::EditUserMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end