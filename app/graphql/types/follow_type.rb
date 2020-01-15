# frozen_string_literal: true

module Types
  class FollowType < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :user, Types::UserType, null: false
    field :follower, Types::UserType, null: false

    def user
      RecordLoader.for(User).load(object.user_id)
    end

    def follower
      RecordLoader.for(User).load(object.follower_id)
    end
  end
end
