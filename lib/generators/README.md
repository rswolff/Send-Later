Rails 3, RSpec, Factory Girl, Haml, and jQuery
==============================================

Easily generate a Rails 3 application with RSpec, Factory Girl, Haml, and
jQuery in one line:

    % rails my_app -J -m \
    http://github.com/rswolff/rails3-app/raw/master/app.rb

Generators
----------

This also gives you the Haml Rails 3 generator

JavaScript Includes
-------------------

Since the Rails helper `javascript_include_tag :defaults` is looking for
Prototype, we use a snippet from Yehuda to change the default JavaScript
Includes to be jQuery.

git
---

We love `git`, so the application has a git repo initialized with all the initial changes staged.

Wrap Up
-------

After the application has been generated, there are a few clean up commands to run:

    % cd my_app
    % gem install bundler
    % bundle install
    % bundle lock