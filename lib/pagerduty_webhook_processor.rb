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
    end

    if has_value?(raw_incident, :assigned_to_user)
      involved_user = raw_incident[:assigned_to_user]
    elsif has_value?(raw_incident, :resolved_by_user)
      involved_user = raw_incident[:resolved_by_user]
    end
    if involved_user != "null" && incident.blackbox.involved_users.where(email: involved_user[:email] ).count == 0
      existing_user = User.find_by(email: involved_user[:email])
      unless existing_user
        incident.blackbox.involved_users.create( full_name: involved_user[:name], email: involved_user[:email] )
      else 
        incident.blackbox.involved_users << existing_user
      end
    end
  end

  private

  def has_value?(struct, sym)
    struct.has_key?(sym) && struct[sym] != "null"
  end
end
