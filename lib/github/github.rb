module Github
  class Client
    def initialize
      @client = $github_client
      @pull_requests = {}
    end

    def total_repos
      repos.size
    end

    def total_prs
      repos.map { |repo| repo[:open_issues_count] }.sum
    end

    def recent_repos
      repos[0..5].map do |repo|
        {
          name: repo.name.titleize,
          open_prs_count: open_pull_requests(repo.name).size,
          last_pr_author: last_pr_author(repo.name)
        }
      end
    end


    private

    attr_reader :client

    def repos(sort_field: :pushed_at)
      @repos ||= client.org_repos('groupbuddies').sort_by { |repo| repo[sort_field] }.reverse
    end

    def open_pull_requests(repo_name)
      @pull_requests[repo_name] ||= client.pull_requests("groupbuddies/#{repo_name}", :open)
    end

    def last_pr_author(repo_name)
      if open_pull_requests(repo_name).any?
        open_pull_requests(repo_name).first.user.login
      end
    end
  end
end
