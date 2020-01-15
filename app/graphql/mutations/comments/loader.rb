# frozen_string_literal: true

module Mutations
  module Comments
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_comment,
                mutation: Mutations::Comments::AddCommentMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :edit_comment,
                mutation: Mutations::Comments::EditCommentMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :delete_comment,
                mutation: Mutations::Comments::DeleteCommentMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
        end
      end
    end
  end
end
