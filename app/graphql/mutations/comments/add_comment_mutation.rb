# frozen_String_literal: true

module Mutations
  module Comments
    class AddCommentMutation < BaseMutation
      null true

      argument :recipe_id, ID, required: true, loads: Types::RecipeType
      argument :rating, Integer, required: false
      argument :text, String, required: false

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: false
 
      def authorized?(**_kwargs)
        return true if context[:ability].can?(:create, Comment)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        comment = Comment.new(recipe: kwargs[:recipe],
                              user: context[:viewer],
                              rating: kwargs[:rating],
                              text: kwargs[:text])

        if comment.save
          { comment: comment, errors: [] }
        else
          { comment: nil, errors: comment.errors.full_messages }
        end
      end
    end
  end
end
