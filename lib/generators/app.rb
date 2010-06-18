empty_directory "lib/generators"
git :clone => "--depth 0 http://github.com/leshill/rails3-app.git lib/generators"
remove_dir "lib/generators/.git"

gemfile = <<-GEMFILE
  source 'http://rubygems.org'

  gem 'rails', '3.0.0.beta4'

  # Bundle edge Rails instead:
  # gem 'rails', :git => 'git://github.com/rails/rails.git'

  gem "haml", ">= 3.0.12"
  gem "compass"
  gem "capistrano"
  gem "mysql"

  # Use unicorn as the web server
  # gem 'unicorn'

  # To use debugger
  # gem 'ruby-debug'

  # Bundle the extra gems:
  # gem 'bj'
  # gem 'nokogiri', '1.4.1'
  # gem 'sqlite3-ruby', :require => 'sqlite3'
  # gem 'aws-s3', :require => 'aws/s3'

  # Bundle gems for certain environments:
  # gem 'rspec', :group => :test
  # group :test do
  #   gem 'webrat'
  # end
  
GEMFILE

remove_file "Gemfile"
create_file "Gemfile", gemfile

generators = <<-GENERATORS

    config.generators do |g|
      g.template_engine :haml
    end
GENERATORS

application generators

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

jquery = <<-JQUERY
module ActionView::Helpers::AssetTagHelper
  remove_const :JAVASCRIPT_DEFAULT_SOURCES
  JAVASCRIPT_DEFAULT_SOURCES = %w(jquery.js jquery-ui.js rails.js)

  reset_javascript_include_default
end
JQUERY

initializer "jquery.rb", jquery

layout = <<-LAYOUT
!!!
%html
  %head
    %title Testapp
    = stylesheet_link_tag 'screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'ie.css', :media => 'screen, projection'
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
    = yield
LAYOUT

remove_file "app/views/layouts/application.html.erb"
create_file "app/views/layouts/application.html.haml", layout

remove_file "public/index.html"

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

capify!

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% gem install bundler
% bundle install
% bundle lock
% script/rails generate rspec:install

DOCS

log docs
