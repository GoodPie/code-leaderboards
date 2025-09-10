class CreateTenants < ActiveRecord::Migration[8.0]
  def change
    create_table :tenants do |t|
      t.string :slug, null: false, index: true
      t.string :name, null: false, index: true
      t.string :logo

      t.belongs_to :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
