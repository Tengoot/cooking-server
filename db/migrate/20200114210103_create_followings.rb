class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :follower, null: false
      t.foreign_key :users, column: :follower_id
      t.timestamps
    end

    add_index(:follows, %i[follower_id user_id], unique: true)
  end
end
