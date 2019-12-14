# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    add_field(GraphQL::Types::Relay::NodeField)
    add_field(GraphQL::Types::Relay::NodesField)

    field :recipe_list, Types::RecipeType.connection_type,
          null: false, max_page_size: 50

    field :show_recipe, Types::RecipeType,
          null: false do
      argument :recipe_id, ID, required: true
    end

    field :ingredient_list, Types::IngredientType.connection_type,
          null: false, max_page_size: 50

    field :show_ingredient, Types::IngredientType,
          null: false do
      argument :ingredient_id, ID, required: true
    end

    field :recipe_ingredient_list, Types::RecipeIngredientType.connection_type,
          null: false, max_page_size: 50 do
      argument :recipe_id, ID, required: true
    end

    field :show_recipe_ingredient, Types::RecipeIngredientType,
          null: false do
      argument :recipe_ingredient_id, ID, required: true
    end

    field :viewer, Types::UserType, null: true

    def recipe_list
      Recipe.all
    end

    def show_recipe(recipe_id:)
      find(node_id: recipe_id)
    end

    def ingredient_list
      Ingredient.all
    end

    def show_ingredient(ingredient_id:)
      find(node_id: ingredient_id)
    end

    def recipe_ingredient_list(recipe_id:)
      recipe = find(node_id: recipe_id)
      return unless recipe.class.name == 'Recipe'

      RecipeIngredient.where(recipe_id: recipe.id)
    end

    def show_recipe_ingredient(recipe_ingredient_id:)
      recipe_ingredient = find(node_id: recipe_ingredient_id)
      return unless recipe_ingredient.class.name == 'RecipeIngredient'

      recipe_ingredient
    end

    def viewer
      context[:warden].user
    end

    private

    def find(node_id:)
      CookingServerSchema.object_from_id(node_id, nil)
    end
  end
end