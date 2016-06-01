class PagerDutyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def webhook
    webhook = PagerDutyWebhookEvent.new( ip: request.headers["REMOTE_ADDR"], body: params )
    if webhook.save
      head :no_content
    else 
      head :unprocessable_entity
    end
  end
end
