require 'pager_duty-connection'
class IncidentManagementService
  def initialize(account, token)
    @account = account
    @token = token
    @pagerduty = PagerDuty::Connection.new(@account, @token)
  end

  def get_incidents
    response = @pagerduty.get('incidents')
    response.incidents # an array of incidents
  end

  def get_incident( incident_id )
    response = @pagerduty.get("incidents/#{incident_id}")
    response
  end

  def get_incident_log( incident_id )
    response = @pagerduty.get("incidents/#{incident_id}/log_entries")
    response.log_entries
  end

  def get_incident_notes( incident_id )
    response = @pagerduty.get("incidents/#{incident_id}/notes")
    response.notes
  end

end
