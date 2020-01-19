# frozen_string_literal: true

module Mutations
  module Users
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :edit_user,
                mutation: Mutations::Users::EditUserMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer].present? },
                mask: ->(ctx) { ctx[:viewer].present? }
          field :forgot_password,
                mutation: Mutations::Users::ForgotPasswordMutation
          field :reset_password,
                mutation: Mutations::Users::ResetPasswordMutation
          field :check_forgot_password_token,
                mutation: Mutations::Users::CheckForgotPasswordMutation
          field :change_user_role,
                mutation: Mutations::Users::ChangeUserRoleMutation,
                guard: ->(_obj, _args, ctx) { ctx[:viewer] && ctx[:viewer].admin? },
                mask: ->(ctx) { ctx[:viewer] && ctx[:viewer].admin? }
        end
      end
    end
  end
end
