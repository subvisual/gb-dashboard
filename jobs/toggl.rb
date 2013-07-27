SCHEDULER.every '5m', first_in: 0 do |job|
  current_projects = TogglStats::WhichProject.new.current_projects

  send_event('toggl', { projects: current_projects.to_json })
end
