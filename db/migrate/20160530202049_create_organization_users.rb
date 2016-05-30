class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true
      t.timestamps null: false
    end
  end
end
