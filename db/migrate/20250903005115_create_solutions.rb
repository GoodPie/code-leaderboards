class CreateSolutions < ActiveRecord::Migration[8.0]
  def change
    create_table :solutions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.text :code
      t.integer :lines_of_code
      t.float :execution_time
      t.datetime :submitted_at
      t.string :github_url

      t.timestamps
    end
  end
end
