class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :solution, null: false, foreign_key: true
      t.string :vote_type

      t.timestamps
    end
  end
end
