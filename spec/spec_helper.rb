require 'simplecov'
SimpleCov.profiles.define 'gem' do
  add_filter '/spec/'
end

if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

SimpleCov.start 'gem'

require 'pry-nav'
require 'thorwald'

require 'active_record'
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

support_files = File.expand_path("spec/support/**/*.rb")
Dir[support_files].each { |file| require file  }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :integration unless ENV['ALL']

  config.order = 'random'

  config.before do
  end
end
