# frozen_string_literal: true

module Mutations
  module Authentication
    class SignInMutation < BaseMutation
      argument :nick, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: false

      def resolve(nick:, password:)
        user = User.find_by_nick(nick)

        if user&.authenticate(password)
          context[:warden].set_user(user)
          context[:warden].request.session_options[:expire_after] = 14.days
          context[:warden].request.session_options[:domain] = 'localhost'
          context[:warden].request.session_options[:secure] = false

          { user: user }
        else
          GraphQL::ExecutionError.new("Wrong nick or password")
        end
      end
    end
  end
end
