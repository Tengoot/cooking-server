# frozen_string_literal: true

module Mutations
  module Authentication
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :sign_in,
                mutation: Mutations::Authentication::SignInMutation
          field :sign_out,
                mutation: Mutations::Authentication::SignOutMutation
          field :sign_up,
                mutation: Mutations::Authentication::SignUpMutation
        end
      end
    end
  end
end
