# frozen_string_literal: true

module Types
  class CommentType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :recipe, Types::RecipeType, null: false
    field :user, Types::UserType, null: false
    field :text, String, null: true
    field :rating, Integer, null: true

    def recipe
      RecordLoader.for(Recipe).load(object.recipe_id)
    end

    def user
      RecordLoader.for(User).load(object.user_id)
    end
  end
end
