# frozen_string_literal: true

module Mutations
  module Authentication
    class SignOutMutation < BaseMutation
      field :user, Types::UserType, null: true

      def resolve
        context[:warden].logout

        { user: context[:viewer] }
      end
    end
  end
end
