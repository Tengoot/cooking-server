# frozen_string_literal: true

module Mutations
  module Authentication
    class SignUpMutation < BaseMutation
      null true

      argument :nick, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(**kwargs)
        user = User.new(kwargs)

        if user.save
          context[:warden].set_user(user)
          context[:warden].request.session_options[:expire_after] = 14.days
          context[:warden].request.session_options[:domain] = 'localhost'
          context[:warden].request.session_options[:secure] = false

          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
