module Types
  class RecipeIngredientType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :amount, Integer, null: false
    field :unit, String, null: false
    field :recipe, Types::RecipeType, null: false
    field :ingredient, Types::IngredientType, null: false

    def recipe
      RecordLoader.for(Recipe).load(object.recipe_id)
    end

    def ingredient
      RecordLoader.for(Ingredient).load(object.ingredient_id)
    end
  end
end
