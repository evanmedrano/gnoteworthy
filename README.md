# README

## Welcome to gnoteworthy!

Hi there! Thanks for checking out the app/github repo! You can visit the
live site here: [gnoteworthy](https://gnoteworthy.herokuapp.com).

This is a simple app to take care of your note-taking needs. You're able
to create, view, update, and delete the notes all on your personal dashboard.

Several other features can be found within the app as well, such as:
* Filtering
* Sorting
* Adjusting the view of the notes dashboard
* Email
* Password protection for your more sensitive notes

For simple javascript functionality, I chose to use
[StimulusJS](https://stimulusjs.org/). I find
Stimulus a pleasure to work with, espcially when only a component or two
need to have extra page interactivity.

The app also leverages several different gems for performance/personal
reasons. Some of the more prominent ones are:
* [Bcrypt](https://github.com/codahale/bcrypt-ruby):
  authentication for password-protected notes

* [Devise](https://github.com/heartcombo/devise):
  for user authentication/authorization

* [Faker](https://github.com/faker-ruby/faker):
  for spicy test data

* [Rspec](https://github.com/rspec/rspec-rails):
  gotta make sure to have my test suite!

* [Sidekiq](https://github.com/mperham/sidekiq):
  for handling my background jobs

* [Slim](https://github.com/slim-template/slim):
  my personal favorite templating choice

All in all, this was a fun app to build and I hope you enjoy!
