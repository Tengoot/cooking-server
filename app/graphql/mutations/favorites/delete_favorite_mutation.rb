# frozen_string_literal: true

module Mutations
  module Favorites
    class DeleteFavoriteMutation < BaseMutation
      null true

      argument :recipe_id, ID, required: true

      field :success, Boolean, null: true
      field :errors, [String], null: false

      def ready?(**kwargs)
        recipe = object_from_id('recipe', kwargs[:recipe_id], context)

        @favorite = Favorite.find_by!(
          recipe_id: recipe.id,
          user_id: context[:viewer].id
        )
      end

      def authorized?(**_kwargs)
        return true if context[:ability].can?(:destroy, favorite)

        [false, { errors: ['Not authorized']}]
      end

      def resolve(**_kwargs)
        if favorite.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: favorite.errors.full_messages }
        end
      end

      private

      attr_reader :favorite
    end
  end
end
