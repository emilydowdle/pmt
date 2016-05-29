require_relative '../test_helper'
class IncidentManagementServiceTest < ActiveSupport::TestCase
  
  live_account = Rails.application.secrets.pagerduty_account
  live_token = Rails.application.secrets.pagerduty_token

  test 'it initializes connection' do
    params = {
      account: 'FAKE_ACCOUNT',
      token: 'FAKE_TOKEN'
    }
    PagerDuty::Connection.expects(:new).with(params[:account], params[:token]).returns({})
    incidentMgmtSvc = IncidentManagementService.new(params)
    assert incidentMgmtSvc
  end

  test 'it gets incidents' do
    skip("reason for skipping the test")
    params = {
      account: 'FAKE_ACCOUNT',
      token: 'FAKE_TOKEN'
    }
    incidentMgmtSvc = IncidentManagementService.new(params)
    incidentMgmtSvc.stubs(:get).returns([])
    assert incidentMgmtSvc.get_incidents
  end

  test 'it gets real incidents' do
    params = {
      account: live_account,
      token: live_token
    }
    incidentMgmtSvc = IncidentManagementService.new(params)
    assert incidentMgmtSvc.get_incidents.kind_of?(Array)
  end
end
