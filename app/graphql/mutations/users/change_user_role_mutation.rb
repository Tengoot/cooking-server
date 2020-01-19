# frozen_string_literal: true

module Mutations
  module Users
    class ChangeUserRoleMutation < BaseMutation
      argument :user_id, ID, loads: Types::UserType, required: true
      argument :role, Types::UserRoleEnum, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def authorized?(**kwargs)
        return true if context[:ability].can?(:change_user_to_mod, kwargs[:user])

        [false, { errors: ['Not authorized']}]
      end

      def resolve(user:, role:)
        case role
        when 'ADMIN'
          user.update(mod: false, admin: true)
        when 'MODERATOR'
          user.update(mod: true, admin: false)
        when 'USER'
          user.update(mod: false, admin: false)
        end

        if user.errors.blank?
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
