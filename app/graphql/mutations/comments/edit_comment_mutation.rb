# frozen_string_literal: true

module Mutations
  module Comments
    class EditCommentMutation < BaseMutation
      null true

      argument :comment_id, ID, required: true, loads: Types::CommentType
      argument :rating, Integer, required: false
      argument :text, String, required: false

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:edit, kwargs[:comment])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        comment = kwargs[:comment]
        comment.assign_attributes(kwargs.except(:comment))

        if comment.save
          { comment: comment, errors: [] }
        else
          { comment: nil, errors: comment.errors.full_messages }
        end
      end
    end
  end
end
