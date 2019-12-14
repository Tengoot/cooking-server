# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false, limit: 256
      t.decimal :average_price, precision: 8, scale: 2
      t.integer :kcal
      t.string :description, null: false, limit: 16_384
      t.text :image_data
      t.timestamps
    end
  end
end
