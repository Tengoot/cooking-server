# frozen_string_literal: true

class AddUserReferenceToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_reference(:recipes, :user, null: false)
    add_foreign_key(:recipes, :users)
  end
end
