class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :encrypted_pagerduty_account
      t.string :encrypted_pagerduty_account_iv
      t.string :encrypted_pagerduty_token
      t.string :encrypted_pagerduty_token_iv
      t.string :slug
      t.timestamps null: false
    end
  end
end
