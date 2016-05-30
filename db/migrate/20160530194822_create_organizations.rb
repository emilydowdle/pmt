class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :encrypted_pagerduty_account
      t.string :encrypted_pagerduty_token

      t.timestamps null: false
    end
  end
end
