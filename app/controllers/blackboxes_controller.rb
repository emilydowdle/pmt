class BlackboxesController < ApplicationController
  include OrganizationSecurity
  before_action do 
    require_membership(params[:organization_slug], current_user)
  end
  
  def index
    @incidents = service.get_incidents
  end

  def show
    @blackbox = Blackbox.find(params[:id])
 end

  private

  def service
    org = get_current_org
    @service ||= IncidentManagementService.new(org.pagerduty_account, org.pagerduty_token)
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

  private

  def get_current_org
    Organization.find_by(slug: params[:organization_slug])
  end

  def require_org_membership
    organization = get_current_org
    if organization.nil? 
      return false
    end
    organization.users.find( current_user )
  end

end
