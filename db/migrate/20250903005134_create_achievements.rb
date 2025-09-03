class CreateAchievements < ActiveRecord::Migration[8.0]
  def change
    create_table :achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :achievement_type
      t.datetime :unlocked_at
      t.references :challenge, null: false, foreign_key: true
      t.json :metadata

      t.timestamps
    end
  end
end
