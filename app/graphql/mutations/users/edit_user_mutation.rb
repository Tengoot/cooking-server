# frozen_string_literal: true

module Mutations
  module Users
    class EditUserMutation < BaseMutation
      null true

      argument :email, String, required: false
      argument :password, String, required: false
      argument :old_password, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def authorized?(**_kwargs)
        return true if context[:ability].can?(:edit, context[:viewer])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**kwargs)
        user = context[:viewer]
        if kwargs[:password]
          if context[:viewer].authenticate(kwargs[:old_password])
            user.update(password: kwargs[:password])
          else
            raise GraphQL::ExecutionError, 'Old password is invalid'
          end
        end
        user.update(email: kwargs[:email]) if kwargs[:email]

        if user.errors.blank?
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
