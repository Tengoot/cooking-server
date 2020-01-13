# frozen_string_literal: true

module ShoppingLists
  class Creator
    def initialize(recipe:, user:, people_count:)
      @recipe = recipe
      @user = user
      @people_count = people_count
    end

    def call
      build_attributes
      create_shopping_list

      shopping_list
    end

    private

    attr_reader :recipe, :user, :people_count, :shopping_list, :attributes

    def build_attributes
      @attributes = base_attributes.merge(
        shopping_list_items_attributes: shopping_list_items_attributes
      )
    end

    def base_attributes
      { recipe_id: recipe.id, user_id: user.id, people_count: people_count }
    end

    def shopping_list_items_attributes
      recipe.recipe_ingredients.map do |recipe_ingredient|
        {
          recipe_ingredient_id: recipe_ingredient.id
        }
      end
    end

    def create_shopping_list
      @shopping_list = ShoppingList.create(attributes)
    end
  end
end
