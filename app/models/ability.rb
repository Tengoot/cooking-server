# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    guest_abilities

    return unless user.present?

    user_abilities(user)
    mod_abilities(user) if user.mod?
    admin_abilities(user) if user.admin?
  end

  def guest_abilities; end

  def user_abilities(user)
    can :manage, ShoppingList, user_id: user.id
    can :manage, ShoppingListItem do |s_item|
      s_item.shopping_list.user_id == user.id
    end
    can :manage, Favorite, user_id: user.id
    can :manage, Follow, follower_id: user.id
    can :manage, Comment, user_id: user.id
    can :manage, User, id: user.id
    can :manage, Recipe, user_id: user.id
  end

  def mod_abilities(_user)
    can :manage, Comment
    can :manage, Recipe
  end

  def admin_abilities(_user)
    can :manage, :all
    can :change_user_to_mod, User
  end
end
