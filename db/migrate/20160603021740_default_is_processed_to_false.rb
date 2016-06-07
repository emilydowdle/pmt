class DefaultIsProcessedToFalse < ActiveRecord::Migration
  def change
    change_column :pager_duty_webhook_events, :is_processed, :boolean, :default => false, :null => false
  end
end
