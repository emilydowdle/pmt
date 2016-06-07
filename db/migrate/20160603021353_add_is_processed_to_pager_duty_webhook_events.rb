class AddIsProcessedToPagerDutyWebhookEvents < ActiveRecord::Migration
  def change
    add_column :pager_duty_webhook_events, :is_processed, :boolean
  end
end
