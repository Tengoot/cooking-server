# frozen_string_literal: true

class AddAvatarData < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_data, :text
  end
end
