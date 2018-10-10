source 'https://rubygems.org'

git_source( :github ) do |repo_name|
  repo_name = "#{ repo_name }/#{ repo_name }" unless repo_name.include?( '/' )
  "https://github.com/#{ repo_name }.git"
end

gem 'better_errors'
gem 'binding_of_caller'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'exception_notification'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'meta_request'
gem 'mysql2'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2.0'
gem 'ruby-saml'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
# gem 'tzinfo-data', platforms: [ :mingw, :mswin, :x64_mingw, :jruby ]
gem 'uglifier', '>= 1.3.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'byebug', platforms: [ :mri, :mingw, :x64_mingw ]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
