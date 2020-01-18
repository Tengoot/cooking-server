# frozen_string_literal: true

module Mutations
  module Users
    class ResetPasswordMutation < BaseMutation
      null true

      argument :token, String, required: true
      argument :password, String, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def resolve(token:, password:)
        user = User.find_by(forgot_password_token: token)

        if user
          user.reset_password!(password)
          { success: true, errors: [] }
        else
          { success: false, errors: ['Token invalid or expired'] }
        end
      end
    end
  end
end
