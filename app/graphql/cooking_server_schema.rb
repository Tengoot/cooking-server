# frozen_string_literal: true

class CookingServerSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
