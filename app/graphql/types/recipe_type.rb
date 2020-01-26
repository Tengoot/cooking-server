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
    field :average_rating, Float, null: false
    field :image_url, String, null: true
    field :recipe_ingredients, [Types::RecipeIngredientType], null: false
    field :comments, [Types::CommentType], null: false
    field :user, Types::UserType, null: false
    field :created_at, String, null: false

    def recipe_ingredients
      AssociationLoader.for(Recipe, :recipe_ingredients).load(object)
    end

    def comments
      AssociationLoader.for(Recipe, :comments).load(object)
    end

    def user
      RecordLoader.for(User).load(object.user_id)
    end

    def average_rating
      return 0.0 unless object.comments.present?

      operation_hash = object.comments
                             .select(&:rating)
                             .group_by(&:rating)
                             .transform_values { |c| c.size }

      sum = operation_hash.inject(0) { |result, (key, value)| result += key * value }
      comments_sum = operation_hash.values.reduce(:+)

      sum.to_f / comments_sum.to_f
    end
  end
end
