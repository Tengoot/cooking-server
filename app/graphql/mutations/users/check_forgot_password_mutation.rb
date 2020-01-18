# frozen_string_literal: true

module Mutations
  module Users
    class CheckForgotPasswordMutation < BaseMutation
      null true

      argument :token, String, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def resolve(token:)
        user = User.find_by(forgot_password_token: token)

        if user && user.password_token_valid?
          { success: true, errors: [] }
        else
          { success: false, errors: ['Token expired or is invalid']}
        end
      end
    end
  end
end
