class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_url
      t.string :google_plus_url
      t.string :gender
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.timestamps null: false
    end
  end
end
