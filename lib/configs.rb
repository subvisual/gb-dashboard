require 'trello'
require 'octokit'

accounts_file = "accounts.yml"
ACCOUNTS = YAML.load_file(accounts_file) if File.exist?(accounts_file) and !defined?(ACCOUNTS)

Trello.configure do |config|
  config.developer_public_key = ACCOUNTS['trello']['public_key']
  config.member_token = ACCOUNTS['trello']['member_token']
end

$github_client = Octokit::Client.new login: ACCOUNTS['github']['login'], oauth_token: ACCOUNTS['github']['oauth_token']
