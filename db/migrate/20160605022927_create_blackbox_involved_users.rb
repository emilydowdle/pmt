class CreateBlackboxInvolvedUsers < ActiveRecord::Migration
  def change
    create_table :blackbox_involved_users do |t|
      t.references :blackbox, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
