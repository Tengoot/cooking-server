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
    field :image_data_uri, String, null: true
    field :recipe_ingredients, [Types::RecipeIngredientType], null: false
    field :comments, [Types::CommentType], null: false

    def recipe_ingredients
      AssociationLoader.for(Recipe, :recipe_ingredients).load(object)
    end

    def comments
      AssociationLoader.for(Recipe, :comments).load(object)
    end

    def average_rating
      return 0.0 unless object.comments.present?

      loaded_comments = GraphQL::Batch.batch { comments }

      operation_hash = loaded_comments
                             .select(&:rating)
                             .group_by(&:rating)
                             .transform_values { |c| c.size }

      sum = operation_hash.inject(0) { |result, (key, value)| result += key * value }
      comments_sum = operation_hash.values.reduce(:+)

      sum.to_f / comments_sum.to_f
    end
  end
end
