# frozen_string_literal: true

module Mutations
  module Follows
    class AddFollowMutation < BaseMutation
      null true

      argument :user_id, ID, loads: Types::UserType, required: true

      field :follow, Types::FollowType, null: true
      field :errors, [String], null: false

      def authorized?(**_kwargs)
        return true if context[:ability].can?(:create, Follow)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(user:)
        follow = Follow.new(user_id: user.id, follower_id: context[:viewer].id)

        if follow.save
          { follow: follow, errors: [] }
        else
          { follow: nil, errors: follow.errors.full_messages }
        end
      end
    end
  end
end
