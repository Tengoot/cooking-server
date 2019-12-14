# frozen_string_literal: true

module Types
  class UserType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :nick, String, null: false
    # TODO: POLICY
    field :email, String, null: true
  end
end
