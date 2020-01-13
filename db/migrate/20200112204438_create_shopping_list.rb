# frozen_string_literal: true

class CreateShoppingList < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_lists do |t|
      t.boolean :archived, null: false, default: false
      t.string :note, limit: 512, null: false, default: ''
      t.integer :people_count, null: false
      t.references :recipe, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true
      t.timestamps
    end

    create_table :shopping_list_items do |t|
      t.boolean :ticked, null: false, default: false
      t.references :shopping_list, null: false, index: true, foreign_key: true
      t.references :recipe_ingredient, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
