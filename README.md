Welcome to my Event Meal Planning App that allows a user to plan meals for an event. 
The program uses user security and authentication to ensure users only have access to their resources.
It follows a standard mvc format.

the program uses the following gems:

gem 'sinatra'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'sqlite3', '~> 1.3.6'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'tux'

It also makes use of MethodOverride for updates and deletes (patch and delete)

It makes use of four models
User - authenticated users of the system. A user has many events.
Event - events that have been setup by users. An event belongs to a userer. An event has many dishes through a join table event_dishes
Dish - dishes were initally populated in the database using seed date; thereafter, users can add dishes to events which populate the database with no user ownership. A dish has many events through a join table event_dishes.
EventDish - join table connecting events to dishes and dishes to events.

The user controller handles typical user signup, login, and failure

The events controller handles displaying events, and allows the user to add and modify events

The dishes controller has not been built out. The idea is that a user could add dishes in bulk (a url link, a csv file, etc.) in a future generation
