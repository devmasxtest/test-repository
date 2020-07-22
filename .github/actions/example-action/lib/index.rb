require 'json'
require 'net/http'
require 'json'
require 'time'
require_relative './github_client'
CHECK_NAME = 'Example'

client = GithubClient.new(ENV['GITHUB_TOKEN'])
check_id = client.post("/repos/#{ENV['GITHUB_REPOSITORY']}/check-runs", {
  name: CHECK_NAME,
  head_sha: ENV['INPUT_GITHUB_TOKEN'],
  status: 'in_progress',
  started_at: Time.now.iso8601
})['id']

client.patch("/repos/#{ENV['GITHUB_REPOSITORY']}/check-runs/#{check_id}", {
  name: CHECK_NAME,
  head_sha: ENV['GITHUB_SHA'],
  status: 'completed',
  completed_at: Time.now.iso8601,
  conclusion: 'Conclusion',
  output: {
    title: CHECK_NAME,
    summary: 'Summary',
    annotations: []
  }
})

puts "Hello world"
