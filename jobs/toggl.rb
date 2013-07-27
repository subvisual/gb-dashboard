current_projects = TogglStats::WhichProject.new.current_projects
SCHEDULER.every '5m', first_in: 0 do |job|
  current_projects = TogglStats::WhichProject.new.current_projects

  send_event('toggl', { projects: current_projects.values.map{|val| {"value" => val}}, members: current_projects.keys.map{|name| "/assets/members/#{name.downcase}.png"} })
end
