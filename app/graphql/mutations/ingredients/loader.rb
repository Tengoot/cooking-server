# frozen_string_literal: true

module Mutations
  module Ingredients
    module Loader
      def self.extended(mutation_type)
        mutation_type.instance_exec do
          field :add_ingredient,
                mutation: Mutations::Ingredients::AddIngredientMutation
          field :edit_ingredient,
                mutation: Mutations::Ingredients::EditIngredientMutation
          field :delete_ingredient,
                mutation: Mutations::Ingredients::DeleteIngredientMutation
        end
      end
    end
  end
end
