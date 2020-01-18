# frozen_string_literal: true

module Mutations
  module Users
    class ForgotPasswordMutation < BaseMutation
      null true

      argument :email, String, required: true

      field :success, Boolean, null: false
      field :errors, [String], null: false

      def resolve(**kwargs)
        user = User.find_by(email: kwargs[:email])

        if user
          user.generate_password_token!
          UserMailer.with(user_id: user.id).forgot_password.deliver_later
        end

        { success: true, errors: []}
      end
    end
  end
end
