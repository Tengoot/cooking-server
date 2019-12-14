# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false, limit: 256
      t.string :time_to_prepare, null: false, limit: 256
      t.string :short_description, limit: 512
      t.string :description, null: false, limit: 16_384
      t.integer :people_count, null: false, default: 0
      t.text :image_data
      t.timestamps
    end
  end
end
