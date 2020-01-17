# frozen_string_literal: true

class AddModAndAdmingFlagToUser < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :admin, :boolean, null: false, default: false)
    add_column(:users, :mod, :boolean, null: false, default: false)
    add_index(:users, :admin)
    add_index(:users, :mod)
  end
end
