class CreatePagerDutyWebhookEvents < ActiveRecord::Migration
  def change
    create_table :pager_duty_webhook_events do |t|
      t.string :ip
      t.jsonb :body

      t.timestamps null: false
    end
  end
end
