# frozen_string_literal: true

module Types
  class UserType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :nick, String, null: false
    field :email, String, null: false,
          guard: ->(type_obj, _args, ctx) { type_obj.object.id == ctx[:viewer]&.id }
    field :avatar_data_uri, String, null: true
    field :recipes, Types::RecipeType.connection_type, null: true, max_page_size: 50
    field :recipe_count, Integer, null: false
    field :favorite_recipes_count, Integer, null: false
    field :followed_users_count, Integer, null: false
    field :followers_count, Integer, null: false

    def recipes
      AssociationLoader.for(User, :recipes).load(object)
    end

    def recipe_count
      CountLoader.for(User, :recipes).load(object)
    end

    def favorite_recipes_count
      CountLoader.for(User, :favorite_recipes).load(object)
    end

    def followed_users_count
      CountLoader.for(User, :users).load(object)
    end

    def followers_count
      CountLoader.for(User, :followers).load(object)
    end
  end
end
