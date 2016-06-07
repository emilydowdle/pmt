class CreateIncidentLogs < ActiveRecord::Migration
  def change
    create_table :incident_logs do |t|
      t.string :action
      t.references :incident, index: true, foreign_key: true
      t.boolean :is_starred
      t.boolean :is_archived

      t.timestamps null: false
    end
  end
end
