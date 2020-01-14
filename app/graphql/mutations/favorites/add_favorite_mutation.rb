# frozen_string_literal: true

module Mutations
  module Favorites
    class AddFavoriteMutation < BaseMutation
      null true

      argument :recipe_id, ID, loads: Types::RecipeType, required: true

      field :favorite, Types::FavoriteType, null: true
      field :errors, [String], null: false

      def authorized?(**_kwargs)
        return true if context[:ability].can?(:create, Favorite)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(recipe:)
        favorite = Favorite.new(recipe_id: recipe.id, user_id: context[:viewer].id)

        if favorite.save
          { favorite: favorite, errors: [] }
        else
          { favorite: nil, errors: favorite.errors.full_messages }
        end
      end
    end
  end
end
