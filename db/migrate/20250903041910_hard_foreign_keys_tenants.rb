class HardForeignKeysTenants < ActiveRecord::Migration[8.0]
  def change
    # tenant_users
    change_column_null :tenant_users, :user_id, false
    change_column_null :tenant_users, :tenant_id, false

    add_foreign_key :tenant_users, :users
    add_foreign_key :tenant_users, :tenants

    add_index :tenant_users, [ :user_id, :tenant_id ], unique: true, name: "index_tenant_users_on_user_and_tenant"

    # tenant_user_roles
    change_column_null :tenant_user_roles, :tenant_user_id, false
    change_column_null :tenant_user_roles, :role_id, false

    add_foreign_key :tenant_user_roles, :tenant_users
    add_foreign_key :tenant_user_roles, :roles

    add_index :tenant_user_roles, [ :tenant_user_id, :role_id ], unique: true, name: "index_tenant_user_roles_on_membership_and_role"
  end
end
