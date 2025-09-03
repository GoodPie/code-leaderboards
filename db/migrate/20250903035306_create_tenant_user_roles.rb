class CreateTenantUserRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :tenant_user_roles do |t|
      t.belongs_to :tenant_user
      t.belongs_to :role

      t.timestamps
    end
  end
end
