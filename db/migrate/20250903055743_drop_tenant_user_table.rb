class DropTenantUserTable < ActiveRecord::Migration[8.0]
  def change
    # Add two new coliumns to `tenant_user_roles` table
    add_reference :tenant_user_roles, :tenant, foreign_key: true
    add_reference :tenant_user_roles, :user, foreign_key: true

    # Get all old `tenant_user` records
    if ActiveRecord::Base.connection.table_exists?("tenant_users")
      TenantUser.all.each do |tenant_user|
        # Add to new columns
        tenant_user.update(tenant: tenant_user.tenant, user: tenant_user.user)
      end
    end

    # Remove association with `tenant_user` table
    remove_reference :tenant_user_roles, :tenant_user, foreign_key: true

    # Drop table
    drop_table :tenant_users

    # Change name of role to enum
    remove_column :roles, :name, :string
    add_column :roles, :name, :string, null: false, default: :member
  end
end
