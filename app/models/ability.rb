# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    guest_abilities

    return unless user.present?

    user_abilities(user)
  end

  def guest_abilities; end

  def user_abilities(user)
    can :manage, ShoppingList, user_id: user.id
    can :manage, ShoppingListItem do |s_item|
      s_item.shopping_list.user_id == user.id
    end
    can :manage, Favorite, user_id: user.id
  end
end
