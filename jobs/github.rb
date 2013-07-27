SCHEDULER.every '1m', :first_in => 0 do |job|
  client = Github::Client.new
  data = {
    total_repos:     client.total_repos,
    total_prs:       client.total_prs,
    recent_repos:    client.recent_repos
  }

  send_event 'github', data
end
