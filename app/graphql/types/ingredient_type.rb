# frozen_string_literal: true

module Types
  class IngredientType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :name, String, null: false
    field :description, String, null: true
    field :average_price, Float, null: true
    field :kcal, Integer, null: true
  end
end
