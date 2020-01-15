# frozen_string_literal: true

module Mutations
  module Follows
    class DeleteFollowMutation < BaseMutation
      null true

      argument :user_id, ID, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def ready?(**kwargs)
        user = object_from_id('user', kwargs[:user_id], context)

        @follow = Follow.find_by!(
          user_id: user.id,
          follower_id: context[:viewer].id
        )
      end

      def authorized?(**kwargs)
        return true if context[:ability].can?(:destroy, follow)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**_kwargs)
        if follow.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: follow.errors.full_messages }
        end
      end

      private

      attr_reader :follow
    end
  end
end
