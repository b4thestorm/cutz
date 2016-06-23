ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'signet/oauth_2/client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
