# frozen_string_literal: true

class AddAcceptedToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column(:recipes, :accepted, :boolean, null: false, default: false)
    add_index(:recipes, :accepted)
  end
end
