source "https://rubygems.org"

gem 'rake'
gem 'yard'

group :development do
  gem 'kramdown'
  gem 'pry'
end

group :test do
  gem 'json', '~> 1.7', :platforms => [:ruby_18, :jruby]
  gem 'rspec', '>= 2.11'
  gem 'webmock'
  gem 'simplecov', :require => false
end

gemspec
