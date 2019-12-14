# frozen_string_literal: true

module Mutations
  module Recipes
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_recipe,
                mutation: Mutations::Recipes::AddRecipeMutation
          field :edit_recipe,
                mutation: Mutations::Recipes::EditRecipeMutation
          field :delete_recipe,
                mutation: Mutations::Recipes::DeleteRecipeMutation
        end
      end
    end
  end
end
