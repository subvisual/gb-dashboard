SCHEDULER.every '1m', :first_in => 0 do |job|
  client = Github::Client.new
  data = {
    repos_count:     client.repos_count,
    total_pr_count:  client.total_pr_count,
    recent_repos:    client.recent_repos
  }

  send_event 'github', data
end
