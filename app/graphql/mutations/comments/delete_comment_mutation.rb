# frozen_String_literal: true

module Mutations
  module Comments
    class DeleteCommentMutation < BaseMutation
      null true

      argument :comment_id, ID, loads: Types::CommentType, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:destroy, kwargs[:comment])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(comment:)
        if comment.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: comment.errors.full_messages }
        end
      end
    end
  end
end
