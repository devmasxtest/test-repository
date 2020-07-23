require 'json'
require 'net/http'
require 'json'
require 'time'
require_relative './github_client'
CHECK_NAME = 'Rubocop Action'

client = GithubClient.new(ENV['INPUT_GITHUB_TOKEN'])
check_id = client.post("/repos/#{ENV['GITHUB_REPOSITORY']}/check-runs", {
  name: CHECK_NAME,
  head_sha: ENV['GITHUB_SHA'],
  status: 'in_progress',
  started_at: Time.now.iso8601
})['id']

client.patch("/repos/#{ENV['GITHUB_REPOSITORY']}/check-runs/#{check_id}", {
  name: CHECK_NAME,
  head_sha: ENV['GITHUB_SHA'],
  status: 'completed',
  completed_at: Time.now.iso8601,
  conclusion: 'failure',
  output: {
    title: CHECK_NAME,
    images: [{
      alt: 'Unicorn error',
      image_url: 'https://user-images.githubusercontent.com/3982052/61085018-a44fdd80-a405-11e9-91aa-99adb8b3a5b3.png',
      caption: 'caption'
    }],
    summary: 'Summary',
    annotations: []
  }
})

puts "Hello world"
exit 1

