class AddUserMetaDetails < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    add_column :users, :github_username, :string
    add_column :users, :bio, :text
    add_column :users, :joined_at, :datetime
  end
end
