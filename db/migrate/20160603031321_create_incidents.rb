class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :name
      t.string :description
      t.references :blackbox, index: true, foreign_key: true
      t.boolean :is_archived

      t.timestamps null: false
    end
  end
end
