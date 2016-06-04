module PagerdutyWebhookProcessor
  def process_messages(organization, messages)
    messages.each{ |m| process_message(organization, m) }
  end

  def process_message(organization, message)
    raw_incident = message[:data][:incident]

    case message[:type]
    when 'incident.trigger'
      blackbox = organization.blackboxes.create!(name: "Blackbox for incident #{raw_incident[:id]}")
      incident = blackbox.incidents.create!(name: "Incident #{raw_incident[:id]}", reference_id: raw_incident[:id])
      incident.incident_logs.create!(action: "triggered") 
    when 'incident.resolve'
      puts 'incident.resolve'
      incident = Incident.find_by(reference_id: raw_incident[:id])
      incident.incident_logs.create!(action:"resolved")
    else 
      incident = Incident.find_by(reference_id: raw_incident[:id])
      incident.incident_logs.create!(action: message[:type].split('.').last)
      # TODO: Extract the user (if one is on event)
    end
  end

end
