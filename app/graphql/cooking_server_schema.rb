# frozen_string_literal: true

require 'graphql/batch'

class CookingServerSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
  use GraphQL::Batch
  use GraphQL::Guard.new(
        not_authorized: ->(type, field) { GraphQL::ExecutionError.new("Not authorized to access #{type}.#{field}") }
      )

  rescue_from(ActiveRecord::RecordNotFound) do |_err, _obj, _args, _ctx, field|
    raise GraphQL::ExecutionError, "#{_err.model} not found"
  end

  def self.id_from_object(object, type_definition, _query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.graphql_name, object.id)
  end

  def self.object_from_id(id, _query_ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)

    type_name.constantize.find(item_id)
  end

  def self.resolve_type(_type, obj, _ctx)
    case obj
    when Recipe
      Types::RecipeType
    when Ingredient
      Types::IngredientType
    when RecipeIngredient
      Types::RecipeIngredientType
    when ShoppingList
      Types::ShoppingListType
    when ShoppingListItem
      Types::ShoppingListItemType
    when Favorite
      Types::FavoriteType
    when Follow
      Types::FollowType
    when User
      Types::UserType
    when Comment
      Types::CommentType
    else
      raise("Unexpected object: #{obj}")
    end
  end
end
