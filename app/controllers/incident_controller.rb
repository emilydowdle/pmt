class IncidentController < ApplicationController

  def index
    @incidents = service.get_incidents
  end

  def show
    @incident = service.get_incident(params['id'])
    @log_entries = normalize_log_entries service.get_incident_log(params['id'])
    @notes = service.get_incident_notes(params['id'])
    @logs_notes = combine_logs_and_notes(@log_entries, @notes)
  end

  private

  def service
    @service ||= IncidentManagementService.new(ENV['PAGERDUTY_ACCOUNT'], ENV['PAGERDUTY_TOKEN'])
  end

  def normalize_log_entries( log_entries )
    log_entries.map do |log|
      case log.type
      when 'assign'
        log.user = log.assigned_user
      when 'notify'
        log.user = {name: '', email: log.notification.address, avatar_url: ''}
      else
        if !log.agent.nil? && log.agent.type == 'user'
          log.user = log.agent
        elsif
          log.user = {name: 'todo: find name', email: '', avatar_url: ''}
          puts log
        end
      end
      log
    end
  end

  def combine_logs_and_notes( log_entries, notes )
    combined = log_entries.concat notes
    combined.compact!
    combined.sort_by{ |h| h.created_at }
  end
end
