# frozen_string_literal: true

class AddForgotPasswordAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :forgot_password_sent_at, :datetime)
    add_column(:users, :forgot_password_token, :string)
    add_index(:users, :forgot_password_token)
  end
end
