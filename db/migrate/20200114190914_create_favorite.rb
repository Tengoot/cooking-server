# frozen_string_literal: true

class CreateFavorite < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.index %i[recipe_id user_id], unique: true
      t.timestamps
    end
  end
end
