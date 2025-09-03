class CreateChallenges < ActiveRecord::Migration[8.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :difficulty
      t.text :starter_code
      t.text :test_suite

      t.timestamps
    end
  end
end
