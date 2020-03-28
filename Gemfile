# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# The authorization Gem for Ruby on Rails
gem 'cancancan'
# Ruby implementation of GraphQL
gem 'graphql'
# A query batching executor for the graphql gem
gem 'graphql-batch'
# Simple authorization interface for GraphQL
gem 'graphql-guard'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# File attachment toolkit for Ruby applications
gem 'shrine'
# Authentication
gem 'warden'
# Application configuration
gem 'config'

group :development, :test do
  # A runtime developer console and IRB alternative with powerful introspection capabilities.
  gem 'pry'
  # Provide MRI Core documentation and source code for the Pry REPL
  gem 'pry-doc'
  # Run pry automatically from rails console
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # RSpec meta-gem that depends on the other components
  gem 'rspec-rails'
  # A Ruby static code analyzer and formatter, based on the community Ruby style guide
  gem 'rubocop', require: false
  # RSpec-specific analysis for your projects, as an extension to RuboCop.
  gem 'rubocop-rspec', require: false
  # Code coverage for Ruby 1.9+ with a powerful configuration library
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
