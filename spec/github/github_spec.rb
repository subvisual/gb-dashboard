require 'spec_helper'
require 'hashie/mash'

describe Github::Client do
  context "#total_repos" do
    it "gets the correct repo count from github API" do
      github = Github::Client.new
      github.stub(:repos).and_return(fake_repos)

      github.repos_count.should eq 5
    end
  end

  context "#total_pr_count" do
    it "gets the correct pr count for each repo" do
      github = Github::Client.new
      github.stub(:repos).and_return(fake_repos)
      github.stub(:open_pull_requests).and_return(fake_pull_requests)

      github.total_pr_count.should eq 10
    end
  end

  context "#recent_repos" do
    it "returns a hash with info for each repo" do
      github = Github::Client.new
      github.stub(:repos).and_return(fake_repos)
      github.stub(:open_pull_requests).and_return(fake_pull_requests)

      github.recent_repos
    end
  end

end

def fake_repos
  @repos ||= %w(phuby-on-phails yo-momma gb-dasbhoard gb-blog awesomesauce).map do |name|
    Hashie::Mash.new name: name
  end
end

def fake_pull_requests(count: 2)
  [
    (Hashie::Mash.new user: (fake_user)),
    (Hashie::Mash.new user: (fake_user))
  ]
end

def fake_user
  Hashie::Mash.new login: 'naps62'
end
