class PagerDutyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include PagerdutyWebhookProcessor

  def webhook
    webhook = PagerDutyWebhookEvent.new( ip: request.headers["REMOTE_ADDR"], is_processed: false, body: params )
    if webhook.save
      process_messages( Organization.find(1), params[:messages] )
      webhook.is_processed = true
      webhook.save
      head :no_content
    else 
      head :unprocessable_entity
    end

  end
end
