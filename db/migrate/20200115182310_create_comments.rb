# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :text, limit: 16_384
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.index %i[recipe_id user_id], unique: true
      t.timestamps
    end
  end
end
