# frozen_string_literal: true

module Types
  class RecipeType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :title, String, null: false
    field :time_to_prepare, String, null: false
    field :short_description, String, null: true
    field :description, String, null: false
    field :people_count, Integer, null: false
    field :recipe_ingredients, [Types::RecipeIngredientType], null: false

    def recipe_ingredients
      AssociationLoader.for(Recipe, :recipe_ingredients).load(object)
    end
  end
end
