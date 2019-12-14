# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :amount, null: false
      t.string :unit, null: false, limit: 256
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.index %i[recipe_id ingredient_id], unique: true
      t.timestamps
    end
  end
end
